package net.syscon.elite.service.impl;

import com.microsoft.applicationinsights.TelemetryClient;
import net.syscon.elite.api.model.Location;
import net.syscon.elite.api.model.ReferenceCode;
import net.syscon.elite.api.model.bulkappointments.*;
import net.syscon.elite.repository.BookingRepository;
import net.syscon.elite.security.AuthenticationFacade;
import net.syscon.elite.service.LocationService;
import net.syscon.elite.service.ReferenceDomainService;
import net.syscon.elite.service.support.ReferenceDomain;
import org.junit.Before;
import org.junit.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import javax.ws.rs.BadRequestException;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.Collections;
import java.util.Optional;
import java.util.stream.Collectors;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

public class AppointmentsServiceImplTest {
    private static final String USERNAME = "username";

    private static final Location LOCATION_A = Location.builder().locationId(0L).agencyId("A").build();
    private static final Location LOCATION_B = Location.builder().locationId(1L).agencyId("B").build();
    private static final Location LOCATION_C = Location.builder().locationId(2L).agencyId("C").build();

    private static final AppointmentDetails DETAILS_1 = AppointmentDetails.builder().bookingId(1L).build();

    private static final AppointmentDetails DETAILS_2 = AppointmentDetails
            .builder()
            .bookingId(2L)
            .startTime(LocalDateTime.of(2018, 2, 27, 13, 30)) // Tuesday
            .endTime(LocalDateTime.of(2018, 2, 27, 13, 50))
            .build();

    private static final AppointmentDetails DETAILS_3 = AppointmentDetails
            .builder()
            .bookingId(2L)
            .startTime(LocalDateTime.of(2018, 2, 27, 13, 30)) // Tuesday
            .build();

    private static final ReferenceCode REFERENCE_CODE_T = ReferenceCode
            .builder()
            .activeFlag("Y")
            .code("T")
            .domain(ReferenceDomain.INTERNAL_SCHEDULE_REASON.getDomain())
            .build();


    @Mock
    private BookingRepository bookingRepository;

    @Mock
    private AuthenticationFacade authenticationFacade;

    @Mock
    private LocationService locationService;

    @Mock
    private ReferenceDomainService referenceDomainService;

    @Mock
    private TelemetryClient telemetryClient;

    @InjectMocks
    private AppointmentsServiceImpl appointmentsService;

    @Before
    public void initMocks() {
        MockitoAnnotations.initMocks(this);
        when(authenticationFacade.getCurrentUsername()).thenReturn(USERNAME);
    }

    @Test(expected = BadRequestException.class)
    public void createTooManyAppointments() {
        appointmentsService.createAppointments(AppointmentsToCreate
                .builder()
                .appointmentDefaults(
                        AppointmentDefaults
                                .builder()
                                .build())
                .appointments(Arrays.asList(new AppointmentDetails[1001]))
                .build());

        verifyNoMoreInteractions(telemetryClient);
    }

    @Test(expected = BadRequestException.class)
    public void locationNotInCaseload() {
        stubLocation(LOCATION_C);

        appointmentsService.createAppointments(
                AppointmentsToCreate
                        .builder()
                        .appointmentDefaults(
                                AppointmentDefaults
                                        .builder()
                                        .locationId(LOCATION_C.getLocationId())
                                        .build())
                        .appointments(Collections.emptyList())
                        .build());

        verifyNoMoreInteractions(telemetryClient);
    }

    @Test(expected = BadRequestException.class)
    public void unknownAppointmentType() {
        stubLocation(LOCATION_B);

        appointmentsService.createAppointments(
                AppointmentsToCreate
                        .builder()
                        .appointmentDefaults(
                                AppointmentDefaults
                                        .builder()
                                        .locationId(LOCATION_B.getLocationId())
                                        .appointmentType("NOT_KNOWN")
                                        .startTime(LocalDateTime.now())
                                        .build())
                        .appointments(Collections.emptyList())
                        .build());

        verifyNoMoreInteractions(telemetryClient);
    }

    @Test
    public void createNoAppointments() {
        stubLocation(LOCATION_B);
        stubValidReferenceCode(REFERENCE_CODE_T);

        appointmentsService.createAppointments(
                AppointmentsToCreate
                        .builder()
                        .appointmentDefaults(
                                AppointmentDefaults
                                        .builder()
                                        .locationId(LOCATION_B.getLocationId())
                                        .appointmentType(REFERENCE_CODE_T.getCode())
                                        .startTime(LocalDateTime.now())
                                        .build())
                        .appointments(Collections.emptyList())
                        .build());

        verifyNoMoreInteractions(telemetryClient);
    }

    @Test(expected = BadRequestException.class)
    public void bookingIdNotInCaseload() {
        stubLocation(LOCATION_B);
        stubValidReferenceCode(REFERENCE_CODE_T);

        appointmentsService.createAppointments(
                AppointmentsToCreate
                        .builder()
                        .appointmentDefaults(
                                AppointmentDefaults
                                        .builder()
                                        .locationId(LOCATION_B.getLocationId())
                                        .appointmentType(REFERENCE_CODE_T.getCode())
                                        .startTime(LocalDateTime.now().plusHours(1))
                                        .build())
                        .appointments(Collections.singletonList(DETAILS_1))
                        .build());

        verifyNoMoreInteractions(telemetryClient);
    }

    @Test
    public void bookingIdInCaseload() {
        stubLocation(LOCATION_B);
        stubValidReferenceCode(REFERENCE_CODE_T);
        stubValidBookingIds(LOCATION_B.getAgencyId(), DETAILS_1.getBookingId());

        final var appointmentsToCreate = AppointmentsToCreate
                .builder()
                .appointmentDefaults(
                        AppointmentDefaults
                                .builder()
                                .locationId(LOCATION_B.getLocationId())
                                .appointmentType(REFERENCE_CODE_T.getCode())
                                .startTime(LocalDateTime.now().plusHours(1))
                                .build())
                .appointments(Collections.singletonList(DETAILS_1))
                .build();

        appointmentsService.createAppointments(appointmentsToCreate);

        verify(bookingRepository)
                .createMultipleAppointments(
                        appointmentsToCreate.withDefaults(),
                        appointmentsToCreate.getAppointmentDefaults(),
                        LOCATION_B.getAgencyId());

        verify(telemetryClient).trackEvent(eq("AppointmentsCreated"), anyMap(), isNull());
    }

    @Test(expected = BadRequestException.class)
    public void appointmentStartTimeTooLate() {
        stubLocation(LOCATION_B);
        stubValidReferenceCode(REFERENCE_CODE_T);
        stubValidBookingIds(LOCATION_B.getAgencyId(), DETAILS_1.getBookingId());

        final var appointmentsToCreate = AppointmentsToCreate
                .builder()
                .appointmentDefaults(
                        AppointmentDefaults
                                .builder()
                                .locationId(LOCATION_B.getLocationId())
                                .appointmentType(REFERENCE_CODE_T.getCode())
                                .startTime(LocalDateTime.now().plusHours(1L))
                                .build())
                .appointments(Collections.singletonList(DETAILS_1))
                .repeat(Repeat
                        .builder()
                        .count(13)
                        .repeatPeriod(RepeatPeriod.MONTHLY)
                        .build())
                .build();

        appointmentsService.createAppointments(appointmentsToCreate);
    }

    @Test(expected = BadRequestException.class)
    public void appointmentEndTimeTooLate() {
        stubLocation(LOCATION_B);
        stubValidReferenceCode(REFERENCE_CODE_T);
        stubValidBookingIds(LOCATION_B.getAgencyId(), DETAILS_1.getBookingId());

        final var appointmentsToCreate = AppointmentsToCreate
                .builder()
                .appointmentDefaults(
                        AppointmentDefaults
                                .builder()
                                .locationId(LOCATION_B.getLocationId())
                                .appointmentType(REFERENCE_CODE_T.getCode())
                                .startTime(LocalDateTime.now().plusHours(1L))
                                .endTime(LocalDateTime.now().plusDays(31L).plusHours(1L))
                                .build())
                .appointments(Collections.singletonList(DETAILS_1))
                .repeat(Repeat
                        .builder()
                        .count(12)
                        .repeatPeriod(RepeatPeriod.MONTHLY)
                        .build())
                .build();

        appointmentsService.createAppointments(appointmentsToCreate);
    }

    @Test(expected = BadRequestException.class)
    public void rejectEndTimeBeforeStartTime() {
        stubLocation(LOCATION_B);
        stubValidReferenceCode(REFERENCE_CODE_T);
        stubValidBookingIds(LOCATION_B.getAgencyId(), DETAILS_1.getBookingId());

        final var appointmentsToCreate = AppointmentsToCreate
                .builder()
                .appointmentDefaults(
                        AppointmentDefaults
                                .builder()
                                .locationId(LOCATION_B.getLocationId())
                                .appointmentType(REFERENCE_CODE_T.getCode())
                                .startTime(LocalDateTime.now().plusHours(2L))
                                .endTime(LocalDateTime.now().plusHours(1L))
                                .build())
                .appointments(Collections.singletonList(DETAILS_1))
                .build();

        appointmentsService.createAppointments(appointmentsToCreate);
    }

    @Test()
    public void acceptEndTimeSameAsStartTime() {
        stubLocation(LOCATION_B);
        stubValidReferenceCode(REFERENCE_CODE_T);
        stubValidBookingIds(LOCATION_B.getAgencyId(), DETAILS_1.getBookingId());

        var in1Hour = LocalDateTime.now().plusHours(1);

        final var appointmentsToCreate = AppointmentsToCreate
                .builder()
                .appointmentDefaults(
                        AppointmentDefaults
                                .builder()
                                .locationId(LOCATION_B.getLocationId())
                                .appointmentType(REFERENCE_CODE_T.getCode())
                                .startTime(in1Hour)
                                .endTime(in1Hour)
                                .build())
                .appointments(Collections.singletonList(DETAILS_1))
                .build();

        appointmentsService.createAppointments(appointmentsToCreate);

        verify(bookingRepository)
                .createMultipleAppointments(
                        appointmentsToCreate.withDefaults(),
                        appointmentsToCreate.getAppointmentDefaults(),
                        LOCATION_B.getAgencyId());
    }

    @Test
    public void shouldHandleNoRepeats() {
        assertThat(AppointmentsServiceImpl.withRepeats(null, Collections.singletonList(DETAILS_2))).containsExactly(DETAILS_2);
    }

    @Test
    public void shouldHandleOneRepeat() {
        assertThat(AppointmentsServiceImpl.withRepeats(
                Repeat.builder().repeatPeriod(RepeatPeriod.DAILY).count(1).build(),
                Collections.singletonList(DETAILS_2)
        ))
                .containsExactly(DETAILS_2);
    }

    @Test
    public void shouldHandleMultipleRepeats() {
        assertThat(AppointmentsServiceImpl.withRepeats(
                Repeat.builder().repeatPeriod(RepeatPeriod.DAILY).count(3).build(),
                Collections.singletonList(DETAILS_2)
        ))
                .containsExactly(
                        DETAILS_2,
                        DETAILS_2.toBuilder().startTime(DETAILS_2.getStartTime().plusDays(1)).endTime(DETAILS_2.getEndTime().plusDays(1)).build(),
                        DETAILS_2.toBuilder().startTime(DETAILS_2.getStartTime().plusDays(2)).endTime(DETAILS_2.getEndTime().plusDays(2)).build()
                );
    }

    @Test
    public void shouldHandleNullEndTime() {
        assertThat(AppointmentsServiceImpl.withRepeats(
                Repeat.builder().repeatPeriod(RepeatPeriod.DAILY).count(2).build(),
                Collections.singletonList(DETAILS_3)
        ))
                .containsExactly(
                        DETAILS_3,
                        DETAILS_3.toBuilder().startTime(DETAILS_3.getStartTime().plusDays(1)).build()
                );
    }

    @Test
    public void shouldRepeatMultipleAppointments() {
        assertThat(AppointmentsServiceImpl.withRepeats(
                Repeat.builder().repeatPeriod(RepeatPeriod.DAILY).count(3).build(),
                Arrays.asList(DETAILS_2, DETAILS_3)
        ))
                .containsExactly(
                        DETAILS_2,
                        DETAILS_2.toBuilder().startTime(DETAILS_2.getStartTime().plusDays(1)).endTime(DETAILS_2.getEndTime().plusDays(1)).build(),
                        DETAILS_2.toBuilder().startTime(DETAILS_2.getStartTime().plusDays(2)).endTime(DETAILS_2.getEndTime().plusDays(2)).build(),
                        DETAILS_3,
                        DETAILS_3.toBuilder().startTime(DETAILS_3.getStartTime().plusDays(1)).build(),
                        DETAILS_3.toBuilder().startTime(DETAILS_3.getStartTime().plusDays(2)).build()
                );
    }

    private void stubValidBookingIds(String agencyId, long... bookingIds) {
        var ids = Arrays.stream(bookingIds).boxed().collect(Collectors.toList());
        when(bookingRepository.findBookingsIdsInAgency(ids, agencyId)).thenReturn(ids);
    }


    private void stubValidReferenceCode(ReferenceCode code) {
        when(referenceDomainService.getReferenceCodeByDomainAndCode(
                ReferenceDomain.INTERNAL_SCHEDULE_REASON.getDomain(),
                code.getCode(),
                false))
                .thenReturn(Optional.of(REFERENCE_CODE_T));
    }

    private void stubLocation(Location location) {
        when(locationService.getUserLocations(anyString())).thenReturn(Arrays.asList(LOCATION_A, LOCATION_B));
        when(locationService.getLocation(location.getLocationId())).thenReturn(location);
    }
}
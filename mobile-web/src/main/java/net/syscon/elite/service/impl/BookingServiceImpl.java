package net.syscon.elite.service.impl;

import net.syscon.elite.api.model.*;
import net.syscon.elite.api.model.SentenceDetail.NonDtoReleaseDateType;
import net.syscon.elite.api.support.Order;
import net.syscon.elite.api.support.Page;
import net.syscon.elite.repository.BookingRepository;
import net.syscon.elite.repository.ReferenceCodeRepository;
import net.syscon.elite.repository.SentenceRepository;
import net.syscon.elite.security.UserSecurityUtils;
import net.syscon.elite.service.*;
import net.syscon.elite.service.support.NonDtoReleaseDate;

import org.apache.commons.lang3.ObjectUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.annotation.Validated;

import javax.validation.Valid;
import javax.ws.rs.BadRequestException;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

import static java.time.LocalDate.now;
import static java.time.temporal.ChronoUnit.DAYS;

/**
 * Bookings API service implementation.
 */
@Service
@Transactional(readOnly = true)
@Validated
public class BookingServiceImpl implements BookingService {

    public static final String INTERNAL_SCHEDULE_REASON = "INT_SCH_RSN";

    private final StartTimeComparator startTimeComparator = new StartTimeComparator();

    private final BookingRepository bookingRepository;
    private final SentenceRepository sentenceRepository;
    private final AgencyService agencyService;
    private final CaseLoadService caseLoadService;
    private final LocationService locationService;
    private final ReferenceCodeRepository referenceCodeRepository;
    private final int lastNumberOfMonths;
    private final String defaultIepLevel;

    /**
     * Order ScheduledEvents by startTime with null coming last
     */
    class StartTimeComparator implements Comparator<ScheduledEvent> {

        @Override
        public int compare(ScheduledEvent event1, ScheduledEvent event2) {
            if (event1.getStartTime() == event2.getStartTime()) {
                return 0;
            } else if (event1.getStartTime() == null) {
                return 1;
            } else if (event2.getStartTime() == null) {
                return -1;
            } else {
                return event1.getStartTime().compareTo(event2.getStartTime());
            }
        }
    }

    public BookingServiceImpl(BookingRepository bookingRepository, SentenceRepository sentenceRepository,
            AgencyService agencyService, CaseLoadService caseLoadService, LocationService locationService,
            ReferenceCodeRepository referenceCodeRepository,
            @Value("${api.offender.release.date.min.months:3}") int lastNumberOfMonths,
            @Value("${api.bookings.iepLevel.default:Unknown}") String defaultIepLevel) {
        this.bookingRepository = bookingRepository;
        this.sentenceRepository = sentenceRepository;
        this.agencyService = agencyService;
        this.caseLoadService = caseLoadService;
        this.locationService = locationService;
        this.referenceCodeRepository = referenceCodeRepository;
        this.lastNumberOfMonths = lastNumberOfMonths;
        this.defaultIepLevel = defaultIepLevel;
    }

    @Override
    public SentenceDetail getBookingSentenceDetail(Long bookingId) {
        verifyBookingAccess(bookingId);

        // Get sentence detail and confirmed release date.
        Optional<SentenceDetail> optSentenceDetail = bookingRepository.getBookingSentenceDetail(bookingId);
        Optional<LocalDate> confirmedReleaseDate = sentenceRepository.getConfirmedReleaseDate(bookingId);

        SentenceDetail sentenceDetail = optSentenceDetail.orElse(
                SentenceDetail.builder().bookingId(bookingId).build());

        // Apply confirmed release date
        sentenceDetail.setConfirmedReleaseDate(confirmedReleaseDate.orElse(null));

        // Determine non-DTO release date
        NonDtoReleaseDate nonDtoReleaseDate = deriveNonDtoReleaseDate(sentenceDetail);

        if (Objects.nonNull(nonDtoReleaseDate)) {
            sentenceDetail.setNonDtoReleaseDate(nonDtoReleaseDate.getReleaseDate());
            sentenceDetail.setNonDtoReleaseDateType(nonDtoReleaseDate.getReleaseDateType());
        }

        // Determine offender release date
        LocalDate releaseDate = deriveOffenderReleaseDate(sentenceDetail);

        sentenceDetail.setReleaseDate(releaseDate);

        return sentenceDetail;
    }

    @Override
    public PrivilegeSummary getBookingIEPSummary(Long bookingId, boolean withDetails) {
        verifyBookingAccess(bookingId);
        List<PrivilegeDetail> iepDetails = bookingRepository.getBookingIEPDetails(bookingId);

        PrivilegeSummary privilegeSummary;

        // If no IEP details exist for offender, cannot derive an IEP summary.
        if (iepDetails.isEmpty()) {
            privilegeSummary = PrivilegeSummary.builder()
                    .bookingId(bookingId)
                    .iepLevel(defaultIepLevel)
                    .iepDetails(Collections.emptyList())
                    .build();
        } else {
            // Extract most recent detail from list
            PrivilegeDetail currentDetail = iepDetails.get(0);

            // Determine number of days since current detail became effective
            long daysSinceReview = DAYS.between(currentDetail.getIepDate(), now());

            privilegeSummary = PrivilegeSummary.builder()
                    .bookingId(bookingId)
                    .iepDate(currentDetail.getIepDate())
                    .iepTime(currentDetail.getIepTime())
                    .iepLevel(currentDetail.getIepLevel())
                    .daysSinceReview(Long.valueOf(daysSinceReview).intValue())
                    .iepDetails(withDetails ? iepDetails : Collections.emptyList())
                    .build();
        }

        return privilegeSummary;
    }

    @Override
    public Page<ScheduledEvent> getBookingActivities(Long bookingId, LocalDate fromDate, LocalDate toDate, long offset, long limit, String orderByFields, Order order) {
        validateScheduledEventsRequest(bookingId, fromDate, toDate);

        String sortFields = StringUtils.defaultString(orderByFields, "startTime");
        Order sortOrder = ObjectUtils.defaultIfNull(order, Order.ASC);

        return bookingRepository.getBookingActivities(bookingId, fromDate, toDate, offset, limit, sortFields, sortOrder);
    }

    @Override
    public List<ScheduledEvent> getBookingActivities(Long bookingId, LocalDate fromDate, LocalDate toDate, String orderByFields, Order order) {
        validateScheduledEventsRequest(bookingId, fromDate, toDate);

        String sortFields = StringUtils.defaultString(orderByFields, "startTime");
        Order sortOrder = ObjectUtils.defaultIfNull(order, Order.ASC);

        return bookingRepository.getBookingActivities(bookingId, fromDate, toDate, sortFields, sortOrder);
    }

    @Override
    public Page<ScheduledEvent> getBookingVisits(Long bookingId, LocalDate fromDate, LocalDate toDate, long offset, long limit, String orderByFields, Order order) {
        validateScheduledEventsRequest(bookingId, fromDate, toDate);

        String sortFields = StringUtils.defaultString(orderByFields, "startTime");
        Order sortOrder = ObjectUtils.defaultIfNull(order, Order.ASC);

        return bookingRepository.getBookingVisits(bookingId, fromDate, toDate, offset, limit, sortFields, sortOrder);
    }

    @Override
    public List<ScheduledEvent> getBookingVisits(Long bookingId, LocalDate fromDate, LocalDate toDate, String orderByFields, Order order) {
        validateScheduledEventsRequest(bookingId, fromDate, toDate);

        String sortFields = StringUtils.defaultString(orderByFields, "startTime");
        Order sortOrder = ObjectUtils.defaultIfNull(order, Order.ASC);

        return bookingRepository.getBookingVisits(bookingId, fromDate, toDate, sortFields, sortOrder);
    }

    @Override
    public ScheduledEvent getBookingVisitLast(Long bookingId) {
        return bookingRepository.getBookingVisitLast(bookingId, LocalDateTime.now());
    }

    @Override
    public Page<ScheduledEvent> getBookingAppointments(Long bookingId, LocalDate fromDate, LocalDate toDate, long offset, long limit, String orderByFields, Order order) {
        validateScheduledEventsRequest(bookingId, fromDate, toDate);

        String sortFields = StringUtils.defaultString(orderByFields, "startTime");
        Order sortOrder = ObjectUtils.defaultIfNull(order, Order.ASC);

        return bookingRepository.getBookingAppointments(bookingId, fromDate, toDate, offset, limit, sortFields, sortOrder);
    }

    @Override
    public List<ScheduledEvent> getBookingAppointments(Long bookingId, LocalDate fromDate, LocalDate toDate, String orderByFields, Order order) {
        validateScheduledEventsRequest(bookingId, fromDate, toDate);

        String sortFields = StringUtils.defaultString(orderByFields, "startTime");
        Order sortOrder = ObjectUtils.defaultIfNull(order, Order.ASC);

        return bookingRepository.getBookingAppointments(bookingId, fromDate, toDate, sortFields, sortOrder);
    }

    @Transactional(readOnly = false)
    @Override
    public ScheduledEvent createBookingAppointment(Long bookingId, @Valid NewAppointment newAppointment) {
        validateStartTime(newAppointment);
        validateEndTime(newAppointment);
        verifyBookingAccess(bookingId);
        final String agencyId = validateLocationAndGetAgency(newAppointment);
        validateEventType(newAppointment);
        Long eventId = bookingRepository.createBookingAppointment(bookingId, newAppointment, agencyId);
        return bookingRepository.getBookingAppointment(bookingId, eventId);
    }

    private void validateStartTime(NewAppointment newAppointment) {
        if (newAppointment.getStartTime().isBefore(LocalDateTime.now())) {
            throw new BadRequestException("Appointment time is in the past.");
        }
    }

    private void validateEndTime(NewAppointment newAppointment) {
        if (newAppointment.getEndTime() != null
                && newAppointment.getEndTime().isBefore(newAppointment.getStartTime())) {
            throw new BadRequestException("Appointment end time is before the start time.");
        }
    }

    private void validateEventType(NewAppointment newAppointment) {
        final Optional<ReferenceCode> result = referenceCodeRepository
                .getReferenceCodeByDomainAndCode(INTERNAL_SCHEDULE_REASON, newAppointment.getAppointmentType(), false);
        if (!result.isPresent()) {
            throw new BadRequestException("Event type not recognised.");
        }
    }

    private String validateLocationAndGetAgency(NewAppointment newAppointment) {
        Location location;
        try {
            location = locationService.getLocation(newAppointment.getLocationId(), false);
        } catch (EntityNotFoundException e) {
            throw new BadRequestException("Location does not exist or is not in your caseload.");
        }
        final String agencyId = location.getAgencyId();
        return agencyId;
    }

    private void validateScheduledEventsRequest(Long bookingId, LocalDate fromDate, LocalDate toDate) {
        // Validate required parameter(s)
        Objects.requireNonNull(bookingId, "bookingId is a required parameter");

        // Validate date range
        if (Objects.nonNull(fromDate) && Objects.nonNull(toDate) && toDate.isBefore(fromDate)) {
            throw new BadRequestException("Invalid date range: toDate is before fromDate.");
        }

        // Verify access to booking for current user
        verifyBookingAccess(bookingId);
    }

    private NonDtoReleaseDate deriveNonDtoReleaseDate(SentenceDetail sentenceDetail) {
        List<NonDtoReleaseDate> nonDtoReleaseDates = new ArrayList<>();

        if (Objects.nonNull(sentenceDetail)) {
            addReleaseDate(nonDtoReleaseDates, sentenceDetail.getAutomaticReleaseDate(), SentenceDetail.NonDtoReleaseDateType.ARD, false);
            addReleaseDate(nonDtoReleaseDates, sentenceDetail.getAutomaticReleaseOverrideDate(), SentenceDetail.NonDtoReleaseDateType.ARD, true);
            addReleaseDate(nonDtoReleaseDates, sentenceDetail.getConditionalReleaseDate(), SentenceDetail.NonDtoReleaseDateType.CRD, false);
            addReleaseDate(nonDtoReleaseDates, sentenceDetail.getConditionalReleaseOverrideDate(), SentenceDetail.NonDtoReleaseDateType.CRD, true);
            addReleaseDate(nonDtoReleaseDates, sentenceDetail.getNonParoleDate(), SentenceDetail.NonDtoReleaseDateType.NPD, false);
            addReleaseDate(nonDtoReleaseDates, sentenceDetail.getNonParoleOverrideDate(), SentenceDetail.NonDtoReleaseDateType.NPD, true);
            addReleaseDate(nonDtoReleaseDates, sentenceDetail.getPostRecallReleaseDate(), SentenceDetail.NonDtoReleaseDateType.PRRD, false);
            addReleaseDate(nonDtoReleaseDates, sentenceDetail.getPostRecallReleaseOverrideDate(), SentenceDetail.NonDtoReleaseDateType.PRRD, true);

            Collections.sort(nonDtoReleaseDates);
        }

        return nonDtoReleaseDates.isEmpty() ? null : nonDtoReleaseDates.get(0);
    }

    private void addReleaseDate(List<NonDtoReleaseDate> nonDtoReleaseDates, LocalDate releaseDate,
                                NonDtoReleaseDateType releaseDateType, boolean isOverride) {

        if (Objects.nonNull(releaseDate)) {
            nonDtoReleaseDates.add(new NonDtoReleaseDate(releaseDateType, releaseDate, isOverride));
        }
    }

    private LocalDate deriveOffenderReleaseDate(SentenceDetail sentenceDetail) {
        // Offender release date is determined according to algorithm.
        //
        // 1. If there is a confirmed release date, the offender release date is the confirmed release date.
        //
        // 2. If there is no confirmed release date for the offender, the offender release date is either the actual
        //    parole date or the home detention curfew actual date.
        //
        // 3. If there is no confirmed release date, actual parole date or home detention curfew actual date for the
        //    offender, the release date is the later of the nonDtoReleaseDate or midTermDate value (if either or both
        //    are present).
        //
        LocalDate releaseDate;

        if (Objects.nonNull(sentenceDetail.getConfirmedReleaseDate())) {
            releaseDate = sentenceDetail.getConfirmedReleaseDate();
        } else if (Objects.nonNull(sentenceDetail.getActualParoleDate())) {
            releaseDate = sentenceDetail.getActualParoleDate();
        } else if (Objects.nonNull(sentenceDetail.getHomeDetentionCurfewActualDate())) {
            releaseDate = sentenceDetail.getHomeDetentionCurfewActualDate();
        } else {
            LocalDate nonDtoReleaseDate = sentenceDetail.getNonDtoReleaseDate();
            LocalDate midTermDate = sentenceDetail.getMidTermDate();

            if (Objects.isNull(midTermDate)) {
                releaseDate = nonDtoReleaseDate;
            } else if (Objects.isNull(nonDtoReleaseDate)) {
                releaseDate = midTermDate;
            } else {
                releaseDate = midTermDate.isAfter(nonDtoReleaseDate) ? midTermDate : nonDtoReleaseDate;
            }
        }

        return releaseDate;
    }

    /**
     * Gets set of agency location ids accessible to current authenticated user. This governs access to bookings - a user
     * cannot have access to an offender unless they are in a location that the authenticated user is also associated with.
     *
     * @return set of agency location ids accessible to current authenticated user.
     */
    private Set<String> getAgencyIds() {
        return agencyService
                .findAgenciesByUsername(UserSecurityUtils.getCurrentUsername())
                .stream()
                .map(Agency::getAgencyId)
                .collect(Collectors.toSet());
    }

    /**
     * Verifies that current user is authorised to access specified offender booking. If offender booking is in an
     * agency location that is not part of any caseload accessible to the current user, a 'Resource Not Found'
     * exception is thrown.
     *
     * @param bookingId offender booking id.
     * @throws EntityNotFoundException if current user does not have access to specified booking.
     */
    @Override
    public void verifyBookingAccess(Long bookingId) {
        Objects.requireNonNull(bookingId, "bookingId is a required parameter");

        if (!bookingRepository.verifyBookingAccess(bookingId, getAgencyIds())) {
            throw EntityNotFoundException.withId(bookingId);
        }
    }

    @Override
    public List<OffenceDetail> getMainOffenceDetails(Long bookingId) {
        verifyBookingAccess(bookingId);

        return sentenceRepository.getMainOffenceDetails(bookingId);
    }

    @Override
    public List<ScheduledEvent> getEventsToday(Long bookingId) {
        final LocalDate today = now();
        return getEvents(bookingId, today, today);
    }

    @Override
    public List<ScheduledEvent> getEventsThisWeek(Long bookingId) {
        final LocalDate today = now();
        return getEvents(bookingId, today, today.plusDays(6));
    }

    @Override
    public List<ScheduledEvent> getEventsNextWeek(Long bookingId) {
        final LocalDate today = now();
        return getEvents(bookingId, today.plusDays(7), today.plusDays(13));
    }

    private List<ScheduledEvent> getEvents(Long bookingId, LocalDate from, LocalDate to) {
        final Page<ScheduledEvent> activitiesPaged = getBookingActivities(bookingId, from, to, 0, 1000, null, null);
        final List<ScheduledEvent> activities = activitiesPaged.getItems();
        if (activitiesPaged.getTotalRecords() > activitiesPaged.getPageLimit()) {
            activities.addAll(getBookingActivities(bookingId, from, to, 1000, activitiesPaged.getTotalRecords(), null, null).getItems());
        }
        final Page<ScheduledEvent> visitsPaged = getBookingVisits(bookingId, from, to, 0, 1000, null, null);
        final List<ScheduledEvent> visits = visitsPaged.getItems();
        if (visitsPaged.getTotalRecords() > visitsPaged.getPageLimit()) {
            visits.addAll(getBookingVisits(bookingId, from, to, 1000, visitsPaged.getTotalRecords(), null, null).getItems());
        }
        final Page<ScheduledEvent> appointmentsPaged = getBookingAppointments(bookingId, from, to, 0, 1000, null, null);
        final List<ScheduledEvent> appointments = appointmentsPaged.getItems();
        if (appointmentsPaged.getTotalRecords() > appointmentsPaged.getPageLimit()) {
            appointments.addAll(getBookingAppointments(bookingId, from, to, 1000, appointmentsPaged.getTotalRecords(), null, null).getItems());
        }
        List<ScheduledEvent> results = new ArrayList<>();
        results.addAll(activities);
        results.addAll(visits);
        results.addAll(appointments);
        Collections.sort(results, startTimeComparator);
        return results;
    }

    @Override
    public Page<OffenderRelease> getOffenderReleaseSummary(LocalDate toReleaseDate, String query, long offset, long limit, String orderByFields, Order order, boolean allowedCaseloadsOnly) {
        return bookingRepository.getOffenderReleaseSummary(toReleaseDate != null ? toReleaseDate : now().plusMonths(lastNumberOfMonths), query, offset, limit, orderByFields, order, allowedCaseloadsOnly ? getUserCaseloadIds() : Collections.emptySet());
    }

    private Set<String> getUserCaseloadIds() {
        return caseLoadService.getCaseLoadIdsForUser(UserSecurityUtils.getCurrentUsername());
    }
}

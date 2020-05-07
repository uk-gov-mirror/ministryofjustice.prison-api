package net.syscon.elite.service;

import lombok.extern.slf4j.Slf4j;
import net.syscon.elite.api.model.PrisonToPrisonMove;
import net.syscon.elite.api.model.ScheduledPrisonToPrisonMove;
import net.syscon.elite.core.HasWriteScope;
import net.syscon.elite.repository.jpa.model.AgencyLocation;
import net.syscon.elite.repository.jpa.model.EscortAgencyType;
import net.syscon.elite.repository.jpa.model.EventStatus;
import net.syscon.elite.repository.jpa.model.OffenderBooking;
import net.syscon.elite.repository.jpa.model.OffenderIndividualSchedule;
import net.syscon.elite.repository.jpa.repository.AgencyLocationRepository;
import net.syscon.elite.repository.jpa.repository.OffenderBookingRepository;
import net.syscon.elite.repository.jpa.repository.OffenderIndividualScheduleRepository;
import net.syscon.elite.repository.jpa.repository.ReferenceCodeRepository;
import net.syscon.elite.security.VerifyBookingAccess;
import net.syscon.elite.service.transformers.AgencyTransformer;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.annotation.Validated;

import java.time.Clock;
import java.time.LocalDateTime;

import static com.google.common.base.Preconditions.checkArgument;
import static net.syscon.elite.repository.jpa.model.EventStatus.SCHEDULED_APPROVED;
import static net.syscon.elite.repository.jpa.model.MovementDirection.OUT;
import static net.syscon.elite.repository.jpa.model.OffenderIndividualSchedule.EventClass.EXT_MOV;

@Service
@Transactional(readOnly = true)
@Validated
@Slf4j
public class PrisonToPrisonMoveSchedulingService {

    private static final String TRANSFER = "TRN";

    private static final String NORMAL_TRANSFER = "NOTR";

    private final Clock clock;

    private final OffenderBookingRepository offenderBookingRepository;

    private final AgencyLocationRepository agencyLocationRepository;

    private final ReferenceCodeRepository<EscortAgencyType> escortAgencyTypeRepository;

    private final ReferenceCodeRepository<EventStatus> eventStatusRepository;

    private final OffenderIndividualScheduleRepository scheduleRepository;

    public PrisonToPrisonMoveSchedulingService(final Clock clock,
                                               final OffenderBookingRepository offenderBookingRepository,
                                               final AgencyLocationRepository agencyLocationRepository,
                                               final ReferenceCodeRepository<EscortAgencyType> escortAgencyTypeRepository,
                                               final ReferenceCodeRepository<EventStatus> eventStatusRepository,
                                               final OffenderIndividualScheduleRepository scheduleRepository) {
        this.clock = clock;
        this.offenderBookingRepository = offenderBookingRepository;
        this.agencyLocationRepository = agencyLocationRepository;
        this.escortAgencyTypeRepository = escortAgencyTypeRepository;
        this.eventStatusRepository = eventStatusRepository;
        this.scheduleRepository = scheduleRepository;
    }

    @Transactional
    @VerifyBookingAccess
    @HasWriteScope
    public ScheduledPrisonToPrisonMove schedule(final Long bookingId, final PrisonToPrisonMove move) {
        log.debug("Scheduling a prison to prison move for booking: {} with details: {}", bookingId, move);

        checkIsInFuture(move.getScheduledMoveDateTime());
        checkNotTheSame(move.getFromPrisonLocation(), move.getToPrisonLocation());

        final var activeBooking = activeOffenderBookingFor(bookingId);

        checkFromLocationMatchesThe(activeBooking, move.getFromPrisonLocation());

        final var escortAgencyType = getEscortAgencyType(move.getEscortType());

        final var scheduledMove = scheduleMove(activeBooking, getActive(move.getToPrisonLocation()), escortAgencyType, move.getScheduledMoveDateTime());

        log.debug("Prison to prison move scheduled with event id: {} for offender: {}, move details: {}",
                scheduledMove.getId(), activeBooking.getOffender().getNomsId(), move);

        return ScheduledPrisonToPrisonMove.builder()
                .id(scheduledMove.getId())
                .scheduledMoveDateTime(scheduledMove.getEventDateTime())
                .fromPrisonLocation(AgencyTransformer.transform(scheduledMove.getFromLocation()))
                .toPrisonLocation(AgencyTransformer.transform(scheduledMove.getToLocation()))
                .build();
    }

    private void checkIsInFuture(final LocalDateTime datetime) {
        checkArgument(datetime.isAfter(LocalDateTime.now(clock)), "Prison to prison move must be in the future.");
    }

    private OffenderBooking activeOffenderBookingFor(final Long bookingId) {
        final var offenderBooking = offenderBookingRepository.findById(bookingId).orElseThrow(EntityNotFoundException.withMessage("Offender booking with id %d not found.", bookingId));

        checkArgument(offenderBooking.isActive(), "Offender booking for prison to prison move with id %s is not active.", bookingId);

        return offenderBooking;
    }

    private void checkFromLocationMatchesThe(final OffenderBooking booking, final String from) {
        checkArgument(booking.getLocation().getId().equals(from), "Prison to prison move from prison does not match that of the booking.");
    }

    private void checkNotTheSame(final String from, final String to) {
        checkArgument(!from.equals(to), "Prison to prison move from and to prisons cannot be the same.");
    }

    private AgencyLocation getActive(final String prison) {
        final var agency = agencyLocationRepository.findById(prison).orElseThrow(() -> EntityNotFoundException.withMessage("Prison with id %s not found.", prison));

        checkArgument(agency.getActiveFlag().isActive(), "Prison with id %s not active.", prison);

        checkArgument(agency.getType().equals("INST"), "Prison to prison move to prison is not a prison.");

        return agency;
    }

    private EscortAgencyType getEscortAgencyType(final String key) {
        return escortAgencyTypeRepository.findById(EscortAgencyType.pk(key))
                .orElseThrow((() -> EntityNotFoundException.withMessage("Escort type %s for prison to prison move not found.", key)));
    }

    private OffenderIndividualSchedule scheduleMove(final OffenderBooking booking,
                                                    final AgencyLocation toPrison,
                                                    final EscortAgencyType escortAgencyType,
                                                    final LocalDateTime moveDateTime) {
        return scheduleRepository.save(OffenderIndividualSchedule.builder()
                .eventDate(moveDateTime.toLocalDate())
                .startTime(moveDateTime)
                .eventClass(EXT_MOV)
                .eventType(TRANSFER)
                .eventSubType(NORMAL_TRANSFER)
                .eventStatus(eventStatusRepository.findById(SCHEDULED_APPROVED).orElseThrow())
                .escortAgencyType(escortAgencyType)
                .fromLocation(booking.getLocation())
                .toLocation(toPrison)
                .movementDirection(OUT)
                .offenderBooking(booking)
                .build());
    }
}
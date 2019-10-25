package net.syscon.elite.service.impl;

import com.microsoft.applicationinsights.TelemetryClient;
import lombok.extern.slf4j.Slf4j;
import net.syscon.elite.api.model.Alert;
import net.syscon.elite.api.model.CreateAlert;
import net.syscon.elite.api.model.ExpireAlert;
import net.syscon.elite.api.support.Order;
import net.syscon.elite.api.support.Page;
import net.syscon.elite.repository.InmateAlertRepository;
import net.syscon.elite.security.AuthenticationFacade;
import net.syscon.elite.security.VerifyAgencyAccess;
import net.syscon.elite.security.VerifyBookingAccess;
import net.syscon.elite.service.EntityNotFoundException;
import net.syscon.elite.service.InmateAlertService;
import net.syscon.elite.service.ReferenceDomainService;
import net.syscon.elite.service.support.ReferenceDomain;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Service
@Transactional(readOnly = true)
@Slf4j
public class InmateAlertServiceImpl implements InmateAlertService {

    private final InmateAlertRepository inmateAlertRepository;
    private final AuthenticationFacade authenticationFacade;
    private final TelemetryClient telemetryClient;
    private final ReferenceDomainService referenceDomainService;

    @Autowired
    public InmateAlertServiceImpl(
            final InmateAlertRepository inmateAlertRepository,
            final AuthenticationFacade authenticationFacade,
            final TelemetryClient telemetryClient,
            final ReferenceDomainService referenceDomainService) {

        this.inmateAlertRepository = inmateAlertRepository;
        this.authenticationFacade = authenticationFacade;
        this.telemetryClient = telemetryClient;
        this.referenceDomainService = referenceDomainService;
    }

    @Override
    @VerifyBookingAccess(overrideRoles = {"SYSTEM_USER", "GLOBAL_SEARCH"})
    public Page<Alert> getInmateAlerts(final Long bookingId, final String query, final String orderBy, final Order order, final long offset, final long limit) {
        final var orderByBlank = StringUtils.isBlank(orderBy);

        final var alerts = inmateAlertRepository.getAlerts(//
                bookingId, query, //
                orderByBlank ? "dateExpires,dateCreated" : orderBy, //
                orderByBlank ? Order.DESC : order, //
                offset, limit);

        alerts.getItems().forEach(alert -> alert.setExpired(isExpiredAlert(alert)));

        log.info("Returning {} of {} matching Alerts starting at {} for bookingId {}", alerts.getItems().size(), alerts.getTotalRecords(), alerts.getPageOffset(), bookingId);
        return alerts;
    }

    @Override
    @VerifyBookingAccess
    public Alert getInmateAlert(final Long bookingId, final Long alertSeqId) {
        final var alert = inmateAlertRepository.getAlert(bookingId, alertSeqId)
                .orElseThrow(EntityNotFoundException.withId(alertSeqId));

        alert.setExpired(isExpiredAlert(alert));

        log.info("Returning Alert having alertSeqId {}, for bookingId {}", alertSeqId, bookingId);
        return alert;
    }

    @Override
    @VerifyAgencyAccess(overrideRoles = {"SYSTEM_READ_ONLY", "SYSTEM_USER", "GLOBAL_SEARCH"})
    public List<Alert> getInmateAlertsByOffenderNosAtAgency(final String agencyId, final List<String> offenderNos) {

        final var alerts = inmateAlertRepository.getAlertsByOffenderNos(agencyId, offenderNos, true, null, "bookingId,alertId", Order.ASC);

        alerts.forEach(alert -> alert.setExpired(isExpiredAlert(alert)));

        log.info("Returning {} matching Alerts for Offender Numbers {} in Agency '{}'", alerts.size(), offenderNos, agencyId);
        return alerts;
    }

    @Override
    @PreAuthorize("hasAnyRole('SYSTEM_READ_ONLY', 'SYSTEM_USER', 'CREATE_CATEGORISATION', 'APPROVE_CATEGORISATION', 'GLOBAL_SEARCH')")
    public List<Alert> getInmateAlertsByOffenderNos(final List<String> offenderNos, final boolean latestOnly, final String query, final String orderByField, final Order order) {

        final var alerts = inmateAlertRepository.getAlertsByOffenderNos(null, offenderNos, latestOnly, query, orderByField, order);
        alerts.forEach(alert -> alert.setExpired(isExpiredAlert(alert)));
        log.info("Returning {} matching Alerts for Offender Numbers {}", alerts.size(), offenderNos);
        return alerts;
    }

    public List<Alert> getInmateAlertsByOffenderNos(final String offenderNo, final boolean latestOnly, final String query, final String orderByField, final Order order) {
        final var alerts = inmateAlertRepository.getAlertsByOffenderNos(null, List.of(offenderNo), latestOnly, query, orderByField, order);
        alerts.forEach(alert -> alert.setExpired(isExpiredAlert(alert)));
        log.info("Returning {} matching Alerts for Offender Number {}", alerts.size(), offenderNo);
        return alerts;
    }

    @Override
    @PreAuthorize("hasAnyRole('SYSTEM_READ_ONLY', 'SYSTEM_USER')")
    public Page<String> getAlertCandidates(final LocalDateTime cutoffTimestamp, final long offset, final long limit) {
        return inmateAlertRepository.getAlertCandidates(cutoffTimestamp, offset, limit);
    }

    @Override
    @Transactional
    @PreAuthorize("hasAnyRole('UPDATE_ALERT')")
    public long createNewAlert(final long bookingId, final CreateAlert alert) {
        final var today = LocalDate.now();
        final var sevenDaysAgo = LocalDate.now().minusDays(7);

        final var existingAlertCode = referenceDomainService
                .getReferenceCodeByDomainAndCode(ReferenceDomain.ALERT.getDomain(), alert.getAlertType(), true)
                .orElseThrow(() -> new IllegalArgumentException("Alert type does not exist."));

        final var isValidAlertCode = existingAlertCode
                .getSubCodes()
                .stream()
                .anyMatch(subCode -> subCode.getCode().equals(alert.getAlertCode()));

        if (!isValidAlertCode)
            throw new IllegalArgumentException("Alert code does not exist.");

        if (alert.getAlertDate().isAfter(today))
            throw new IllegalArgumentException("Alert date cannot be in the future.");

        if (alert.getAlertDate().isBefore(sevenDaysAgo))
            throw new IllegalArgumentException("Alert date cannot go back more than seven days.");

        final var existingActiveAlerts = inmateAlertRepository.getActiveAlerts(bookingId);
        final var matches = existingActiveAlerts
                .stream().anyMatch(al -> al.getAlertType().equals(alert.getAlertType()) &&
                        al.getAlertCode().equals(alert.getAlertCode()));

        if (matches) throw new IllegalArgumentException("Alert already exists for this offender.");

        final var username = authenticationFacade.getCurrentUsername();
        final var alertId = inmateAlertRepository.createNewAlert(bookingId, alert);

        log.info("Created new alert {}", alert);
        telemetryClient.trackEvent("Alert created", Map.of(
                "bookingId", String.valueOf(bookingId),
                "alertSeq", String.valueOf(alertId),
                "alertDate", alert.getAlertDate().toString(),
                "alertCode", alert.getAlertCode(),
                "alertType", alert.getAlertType(),
                "created_by", username
        ), null);

        return alertId;
    }

    @Override
    @Transactional
    @PreAuthorize("hasAnyRole('UPDATE_ALERT')")
    public Alert expireAlert(final long bookingId, final long alertSeq, final ExpireAlert expireAlert) {
        final var username = authenticationFacade.getCurrentUsername();

        final var existingAlert = inmateAlertRepository.getAlert(bookingId, alertSeq)
                .orElseThrow(EntityNotFoundException.withId(alertSeq));

        if (!existingAlert.isActive())
            throw new IllegalArgumentException("Alert is already inactive.");

        final var alert = inmateAlertRepository.expireAlert(bookingId, alertSeq, expireAlert)
                .orElseThrow(EntityNotFoundException.withId(alertSeq));

        log.info("Updated updated {}", alert);
        telemetryClient.trackEvent("Alert updated", Map.of(
                "bookingId", String.valueOf(bookingId),
                "alertSeq", String.valueOf(alertSeq),
                "expiryDate", expireAlert.getExpiryDate().toString(),
                "updated_by", username
        ), null);


        return alert;
    }

    private boolean isExpiredAlert(final Alert alert) {
        var expiredAlert = false;

        if (alert.getDateExpires() != null) {
            expiredAlert = alert.getDateExpires().compareTo(LocalDate.now()) <= 0;
        }

        return expiredAlert;
    }
}

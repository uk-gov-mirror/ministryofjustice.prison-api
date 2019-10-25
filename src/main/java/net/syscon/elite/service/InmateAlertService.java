package net.syscon.elite.service;

import net.syscon.elite.api.model.Alert;
import net.syscon.elite.api.model.CreateAlert;
import net.syscon.elite.api.model.ExpireAlert;
import net.syscon.elite.api.support.Order;
import net.syscon.elite.api.support.Page;
import org.springframework.security.access.prepost.PreAuthorize;

import java.time.LocalDateTime;
import java.util.List;

public interface InmateAlertService {
    Page<Alert> getInmateAlerts(Long bookingId, String query, String orderBy, Order order, long offset, long limit);

    Alert getInmateAlert(Long bookingId, Long alertSeqId);

    List<Alert> getInmateAlertsByOffenderNosAtAgency(String agencyId, List<String> offenderNos);

    List<Alert> getInmateAlertsByOffenderNos(List<String> offenderNos, boolean latestOnly, String query, String orderByField, Order order);

    List<Alert> getInmateAlertsByOffenderNos(String offenderNo, boolean latestOnly, String query, String orderByField, Order order);

    @PreAuthorize("hasAnyRole('SYSTEM_READ_ONLY', 'SYSTEM_USER')")
    Page<String> getAlertCandidates(LocalDateTime cutoffTimestamp, long offset, long limit);

    long createNewAlert(long bookingId, CreateAlert alert);

    Alert expireAlert(long bookingId, long alertSeq, ExpireAlert alert);
}

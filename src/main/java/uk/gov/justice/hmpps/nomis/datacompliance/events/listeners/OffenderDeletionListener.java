package uk.gov.justice.hmpps.nomis.datacompliance.events.listeners;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import uk.gov.justice.hmpps.nomis.datacompliance.events.dto.OffenderDeletionEvent;
import uk.gov.justice.hmpps.nomis.datacompliance.events.dto.SqsEvent;
import uk.gov.justice.hmpps.nomis.datacompliance.service.OffenderDataComplianceService;
import org.springframework.boot.autoconfigure.condition.ConditionalOnExpression;
import org.springframework.jms.annotation.JmsListener;
import org.springframework.stereotype.Service;

import java.io.IOException;

import static com.google.common.base.Preconditions.checkState;
import static org.apache.commons.lang3.ObjectUtils.isNotEmpty;

@Slf4j
@Service
@ConditionalOnExpression("'${offender.deletion.sqs.provider}'.equals('aws') or '${offender.deletion.sqs.provider}'.equals('localstack')")
public class OffenderDeletionListener {

    private static final String EXPECTED_EVENT_TYPE = "DATA_COMPLIANCE_DELETE-OFFENDER";

    private final OffenderDataComplianceService offenderDataComplianceService;
    private final ObjectMapper objectMapper;

    public OffenderDeletionListener(final OffenderDataComplianceService offenderDataComplianceService,
                                    final ObjectMapper objectMapper) {

        log.info("Configured to listen to Offender Deletion events");

        this.offenderDataComplianceService = offenderDataComplianceService;
        this.objectMapper = objectMapper;
    }

    @JmsListener(destination = "${offender.deletion.sqs.queue.name}")
    public void handleOffenderDeletionEvent(final String requestJson) {

        log.debug("Handling incoming offender deletion request: {}", requestJson);

        offenderDataComplianceService.deleteOffender(
                getOffenderIdDisplay(requestJson));
    }

    private String getOffenderIdDisplay(final String requestJson) {

        final OffenderDeletionEvent event = parseOffenderDeletionEvent(requestJson);

        checkState(isNotEmpty(event.getOffenderIdDisplay()), "No offender specified in request: %s", requestJson);

        return event.getOffenderIdDisplay();
    }

    private OffenderDeletionEvent parseOffenderDeletionEvent(final String requestJson) {
        try {
            final SqsEvent message = objectMapper.readValue(requestJson, SqsEvent.class);

            checkState(EXPECTED_EVENT_TYPE.equals(message.getEventType()),
                    "Unexpected message event type: '%s', expecting: '%s'", message.getEventType(), EXPECTED_EVENT_TYPE);

            return objectMapper.readValue(message.getMessage(), OffenderDeletionEvent.class);

        } catch (final IOException e) {
            throw new RuntimeException("Failed to parse request: " + requestJson, e);
        }
    }
}
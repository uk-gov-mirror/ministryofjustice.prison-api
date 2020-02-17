package uk.gov.justice.hmpps.nomis.datacompliance.events.publishers;

import com.amazonaws.services.sns.AmazonSNS;
import com.amazonaws.services.sns.model.MessageAttributeValue;
import com.amazonaws.services.sns.model.PublishRequest;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import uk.gov.justice.hmpps.nomis.datacompliance.events.dto.OffenderPendingDeletionEvent;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.stereotype.Component;

import java.util.Map;

@Slf4j
@Component
@ConditionalOnProperty(name = "offender.deletion.sns.provider")
public class OffenderPendingDeletionAwsEventPusher implements OffenderPendingDeletionEventPusher {

    private final ObjectMapper objectMapper;
    private final AmazonSNS snsClient;
    private final String topicArn;

    public OffenderPendingDeletionAwsEventPusher(final AmazonSNS snsClient,
                                                 @Value("${offender.deletion.sns.topic.arn}") final String topicArn,
                                                 final ObjectMapper objectMapper) {

        log.info("Configured to push offender pending deletion events to SNS topic: {}", topicArn);

        this.objectMapper = objectMapper;
        this.snsClient = snsClient;
        this.topicArn = topicArn;
    }

    @Override
    public void sendEvent(final String offenderNo) {

        log.debug("Sending referral of offender pending deletion: {}", offenderNo);

        snsClient.publish(generateRequest(offenderNo));
    }

    private PublishRequest generateRequest(final String offenderNo) {
        return new PublishRequest()
                .withTopicArn(topicArn)
                .withMessageAttributes(Map.of(
                        "eventType", stringAttribute("DATA_COMPLIANCE_OFFENDER-PENDING-DELETION"),
                        "contentType", stringAttribute("text/plain;charset=UTF-8")))
                .withMessage(toJson(new OffenderPendingDeletionEvent(offenderNo)));
    }

    private MessageAttributeValue stringAttribute(final String value) {
        return new MessageAttributeValue()
                .withDataType("String")
                .withStringValue(value);
    }

    private String toJson(final OffenderPendingDeletionEvent event) {
        try {
            return objectMapper.writeValueAsString(event);
        } catch (final Exception e) {
            throw new RuntimeException(e);
        }
    }
}
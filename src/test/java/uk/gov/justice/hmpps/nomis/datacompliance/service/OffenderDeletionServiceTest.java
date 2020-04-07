package uk.gov.justice.hmpps.nomis.datacompliance.service;

import com.microsoft.applicationinsights.TelemetryClient;
import net.syscon.elite.repository.OffenderDeletionRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import uk.gov.justice.hmpps.nomis.datacompliance.events.dto.OffenderDeletionCompleteEvent;
import uk.gov.justice.hmpps.nomis.datacompliance.events.publishers.OffenderDeletionEventPusher;

import java.util.Map;
import java.util.Set;

import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class OffenderDeletionServiceTest {

    private static final String OFFENDER_NUMBER = "A1234AA";
    private static final String OFFENDER_ID = "123";

    @Mock
    private OffenderDeletionRepository offenderDeletionRepository;

    @Mock
    private OffenderDeletionEventPusher offenderDeletionEventPusher;

    @Mock
    private TelemetryClient telemetryClient;

    private OffenderDeletionService service;

    @BeforeEach
    public void setUp() {
        service = new OffenderDeletionService(offenderDeletionRepository, offenderDeletionEventPusher, telemetryClient);
    }

    @Test
    public void deleteOffender() {
        when(offenderDeletionRepository.deleteOffender(OFFENDER_NUMBER)).thenReturn(Set.of(OFFENDER_ID));

        service.deleteOffender(OFFENDER_NUMBER);

        verify(offenderDeletionEventPusher).sendDeletionCompleteEvent(new OffenderDeletionCompleteEvent(OFFENDER_NUMBER));
        verify(telemetryClient).trackEvent("OffenderDelete", Map.of("offenderNo", OFFENDER_NUMBER, "count", "1"), null);
    }
}
package net.syscon.elite.repository;

import net.syscon.elite.api.model.CaseNoteEvent;
import net.syscon.elite.api.model.CaseNoteUsageByBookingId;
import net.syscon.elite.api.model.NewCaseNote;
import net.syscon.elite.api.model.ReferenceCode;
import net.syscon.elite.web.config.CacheConfig;
import net.syscon.elite.web.config.PersistenceConfigs;
import org.assertj.core.groups.Tuple;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.JdbcTest;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace.NONE;

@ActiveProfiles("test")
@RunWith(SpringRunner.class)
@Transactional(propagation = Propagation.NOT_SUPPORTED)
@JdbcTest
@AutoConfigureTestDatabase(replace = NONE)
@ContextConfiguration(classes = { PersistenceConfigs.class, CacheConfig.class })
public class CaseNoteRepositoryTest {

    @Autowired
    private CaseNoteRepository repository;

    @Autowired
    JdbcTemplate jdbcTemplate;

    @Test
    public void testGetCaseNoteTypesByCaseLoadType() {
        final var types = repository.getCaseNoteTypesByCaseLoadType("COMM");

        assertThat(types).isNotEmpty();
        //noinspection unchecked
        assertThat(types).extracting(ReferenceCode::getSubCodes).containsOnly(List.of());
    }

    @Test
    public void testGetCaseNoteTypeWithSubTypesByCaseLoadType() {
        final var types = repository.getCaseNoteTypesWithSubTypesByCaseLoadType("COMM");

        // Spot check
        final var type = types.stream().filter(x -> x.getCode().equals("DRR")).findFirst();
        assertThat(type).isPresent();

        final var subTypes = type.orElseThrow().getSubCodes();

        assertThat(subTypes).extracting(ReferenceCode::getCode).contains("DTEST");
    }

    @Test
    public void testCreateCaseNote() {

        final var startTime = LocalDateTime.now().truncatedTo(ChronoUnit.SECONDS);

        final long bookingId = -4;
        final var newCaseNote = newCaseNote();
        final var sourceCode = "source code";
        final var username = "username";
        final long staffId = -2;
        final long caseNoteId = repository.createCaseNote(bookingId, newCaseNote, sourceCode, username, staffId);

        final var map = jdbcTemplate.queryForMap("select TIME_CREATION, CREATE_DATETIME from offender_case_notes where CASE_NOTE_ID = ?", caseNoteId);

        final var timeCreation = ((Timestamp) map.get("TIME_CREATION")).toLocalDateTime();
        final var createDateTime = ((Timestamp) map.get("CREATE_DATETIME")).toLocalDateTime();

        assertThat(timeCreation).isBetween(startTime, startTime.plusSeconds(5));

        assertThat(timeCreation).isBetween(createDateTime.minusSeconds(1), createDateTime.plusSeconds(1));


        jdbcTemplate.update("delete from offender_case_notes where case_note_id = ?", caseNoteId);
    }

    @Test
    public void testCaseNoteTimes() {
        final long bookingId = -4;
        final var newCaseNote = newCaseNote();
        final var sourceCode = "source code";
        final var username = "username";
        final long staffId = -2;
        final long caseNoteId = repository.createCaseNote(bookingId, newCaseNote, sourceCode, username, staffId);

        final var caseNote = repository.getCaseNote(-4, caseNoteId).orElseThrow();

        final var contactDateTime = caseNote.getOccurrenceDateTime();
        final var createDateTime = caseNote.getCreationDateTime();

        assertThat(contactDateTime).isBetween(createDateTime.minusSeconds(2), createDateTime.plusSeconds(1));

        jdbcTemplate.update("delete from offender_case_notes where case_note_id = ?", caseNoteId);
    }

    @Test
    public void getCaseNoteUsageByBookingIdSingleCaseNote() {
        final var notes = repository.getCaseNoteUsageByBookingId("COMMS", "COM_OUT", List.of(-2), LocalDate.of(2017, 1, 1), LocalDate.of(2018, 1, 1));

        assertThat(notes).containsOnly(new CaseNoteUsageByBookingId(-2, "COMMS", "COM_OUT", 1, LocalDateTime.parse("2017-05-06T17:11:00")));
    }

    @Test
    public void getCaseNoteUsageByBookingIdMultipleCaseNote() {
        final var notes = repository.getCaseNoteUsageByBookingId("OBSERVE", "OBS_GEN", List.of(-3), LocalDate.of(2017, 1, 1), LocalDate.of(2017, 8, 1));

        assertThat(notes).containsOnly(new CaseNoteUsageByBookingId(-3, "OBSERVE", "OBS_GEN", 6, LocalDateTime.parse("2017-07-31T12:00")));
    }

    @Test
    public void getCaseNoteUsageByBookingIdMultipleBookingIds() {
        final var notes = repository.getCaseNoteUsageByBookingId("OBSERVE", "OBS_GEN", List.of(-16, -3), LocalDate.of(2017, 1, 1), LocalDate.of(2017, 8, 1));

        assertThat(notes).containsOnly(
                new CaseNoteUsageByBookingId(-3, "OBSERVE", "OBS_GEN", 6, LocalDateTime.parse("2017-07-31T12:00")),
                new CaseNoteUsageByBookingId(-16, "OBSERVE", "OBS_GEN", 1, LocalDateTime.parse("2017-05-13T12:00")));
    }

    @Test
    public void getCaseNoteEvents() {
        final var start = LocalDateTime.now();
        final var caseNote = newCaseNote();
        caseNote.setText("Testing of events");
        final var id = repository.createCaseNote(-4, caseNote, "source", "user", -2L);

        final var caseNoteEvents = repository.getCaseNoteEvents(start);
        assertThat(caseNoteEvents).extracting(
                CaseNoteEvent::getNomsId,
                CaseNoteEvent::getId,
                CaseNoteEvent::getContent,
                CaseNoteEvent::getEstablishmentCode,
                CaseNoteEvent::getNoteType,
                CaseNoteEvent::getStaffName
        ).contains(Tuple.tuple(
                "A1234AD",
                id,
                "Testing of events",
                "LEI",
                "GEN HIS",
                "User, Api"
        ));
        final var event = caseNoteEvents.stream().filter((e) -> e.getContent().equals("Testing of events")).findFirst().orElseThrow();
        assertThat(event.getContactTimestamp()).isBetween(start.minusSeconds(1), LocalDateTime.now().plusSeconds(1));
        assertThat(event.getNotificationTimestamp()).isBetween(start.minusSeconds(1), LocalDateTime.now().plusSeconds(1));
    }

    private NewCaseNote newCaseNote() {
        final var newCaseNote = new NewCaseNote();
        newCaseNote.setText("text");
        newCaseNote.setType("GEN");
        newCaseNote.setSubType("HIS");
        return newCaseNote;
    }
}

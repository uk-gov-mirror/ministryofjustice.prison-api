package net.syscon.elite.v2.repository.impl;

import jersey.repackaged.com.google.common.collect.ImmutableMap;
import net.syscon.elite.persistence.impl.RepositoryBase;
import net.syscon.elite.persistence.mapping.FieldMapper;
import net.syscon.elite.persistence.mapping.Row2BeanRowMapper;
import net.syscon.elite.v2.api.model.SentenceDetail;
import net.syscon.elite.v2.repository.BookingRepository;
import net.syscon.util.DateFormatProvider;
import net.syscon.util.IQueryBuilder;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.Map;
import java.util.Optional;

/**
 * Bookings API (v2) repository implementation.
 */
@Repository
public class BookingRepositoryImpl extends RepositoryBase implements BookingRepository {
    private final Map<String, FieldMapper> sentenceDetailMapping =
            new ImmutableMap.Builder<String, FieldMapper>()
                    .put("OFFENDER_BOOK_ID", new FieldMapper("bookingId"))
                    .put("SENTENCE_START_DATE", new FieldMapper("sentenceStartDate", DateFormatProvider::toISO8601LocalDate))
                    .put("SENTENCE_EXPIRY_DATE", new FieldMapper("sentenceExpiryDate", DateFormatProvider::toISO8601LocalDate))
                    .put("CRD_OVERRIDED_DATE", new FieldMapper("conditionalReleaseOverrideDate", DateFormatProvider::toISO8601LocalDate))
                    .put("CRD_CALCULATED_DATE", new FieldMapper("conditionalReleaseDate", DateFormatProvider::toISO8601LocalDate))
                    .put("ARD_OVERRIDED_DATE", new FieldMapper("automaticReleaseOverrideDate", DateFormatProvider::toISO8601LocalDate))
                    .put("ARD_CALCULATED_DATE", new FieldMapper("automaticReleaseDate", DateFormatProvider::toISO8601LocalDate))
                    .put("NPD_OVERRIDED_DATE", new FieldMapper("nonParoleOverrideDate", DateFormatProvider::toISO8601LocalDate))
                    .put("NPD_CALCULATED_DATE", new FieldMapper("nonParoleDate", DateFormatProvider::toISO8601LocalDate))
                    .put("PRRD_OVERRIDED_DATE", new FieldMapper("postRecallReleaseOverrideDate", DateFormatProvider::toISO8601LocalDate))
                    .put("PRRD_CALCULATED_DATE", new FieldMapper("postRecallReleaseDate", DateFormatProvider::toISO8601LocalDate))
                    .put("LICENCE_EXPIRY_DATE", new FieldMapper("licenceExpiryDate", DateFormatProvider::toISO8601LocalDate))
                    .put("PAROLE_ELIGIBILITY_DATE", new FieldMapper("paroleEligibilityDate", DateFormatProvider::toISO8601LocalDate))
                    .put("HOME_DET_CURF_ELIGIBILITY_DATE", new FieldMapper("homeDetentionCurfewEligibilityDate", DateFormatProvider::toISO8601LocalDate))
                    .put("EARLY_TERM_DATE", new FieldMapper("earlyTermDate", DateFormatProvider::toISO8601LocalDate))
                    .put("MID_TERM_DATE", new FieldMapper("midTermDate", DateFormatProvider::toISO8601LocalDate))
                    .put("LATE_TERM_DATE", new FieldMapper("lateTermDate", DateFormatProvider::toISO8601LocalDate))
                    .put("ADDITIONAL_DAYS_AWARDED", new FieldMapper("additionalDaysAwarded"))
                    .build();

    @Override
    public Optional<SentenceDetail> getBookingSentenceDetail(Long bookingId) {
        String initialSql = getQuery("GET_BOOKING_SENTENCE_DETAIL");
        IQueryBuilder builder = queryBuilderFactory.getQueryBuilder(initialSql, sentenceDetailMapping);
        String sql = builder.build();

        RowMapper<SentenceDetail> sentenceDetailRowMapper =
                Row2BeanRowMapper.makeMapping(sql, SentenceDetail.class, sentenceDetailMapping);

        SentenceDetail sentenceDetail = null;

        try {
            sentenceDetail =
                    jdbcTemplate.queryForObject(
                            sql,
                            createParams("bookingId", bookingId),
                            sentenceDetailRowMapper);

        } catch (EmptyResultDataAccessException ex) {
            sentenceDetail = null;
        }

        return Optional.ofNullable(sentenceDetail);
    }
}
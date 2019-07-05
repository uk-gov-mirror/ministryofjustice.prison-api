package net.syscon.elite.repository.v1.storedprocs;

import net.syscon.elite.repository.mapping.StandardBeanPropertyRowMapper;
import net.syscon.elite.repository.v1.NomisV1SQLErrorCodeTranslator;
import net.syscon.elite.repository.v1.model.AliasSP;
import net.syscon.elite.repository.v1.model.OffenderSP;
import org.springframework.jdbc.core.RowMapperResultSetExtractor;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Component;

import javax.sql.DataSource;
import java.sql.Types;


public class OffenderProcs {

    private static final String API_OFFENDER_PROCS = "api_offender_procs";

    @Component
    public static class GetOffenderDetails extends SimpleJdbcCallWithExceptionTranslater {

        public GetOffenderDetails(final DataSource dataSource, final NomisV1SQLErrorCodeTranslator errorCodeTranslator) {
            super(dataSource, errorCodeTranslator);
            withSchemaName(StoreProcMetadata.API_OWNER)
                    .withCatalogName(API_OFFENDER_PROCS)
                    .withProcedureName("get_offender_details")
                    .withNamedBinding()
                    .declareParameters(
                            new SqlParameter(StoreProcMetadata.P_NOMS_ID, Types.VARCHAR),
                            new SqlOutParameter(StoreProcMetadata.P_OFFENDER_CSR, Types.REF_CURSOR))
                    .returningResultSet(StoreProcMetadata.P_OFFENDER_CSR,
                            (rs, rowNum) -> {
                                final var offender = StandardBeanPropertyRowMapper.newInstance(OffenderSP.class).mapRow(rs, rowNum);
                                if (offender != null) {
                                    offender.setOffenderAliases(new RowMapperResultSetExtractor<>
                                            (StandardBeanPropertyRowMapper.newInstance(AliasSP.class))
                                            .extractData(offender.getAliases()));
                                }
                                return offender;
                            });
            compile();
        }
    }

    @Component
    public static class GetOffenderImage extends SimpleJdbcCallWithExceptionTranslater {

        public static final String P_IMAGE = "p_image";

        public GetOffenderImage(final DataSource dataSource, final NomisV1SQLErrorCodeTranslator errorCodeTranslator) {
            super(dataSource, errorCodeTranslator);
            withSchemaName(StoreProcMetadata.API_OWNER)
                    .withCatalogName(API_OFFENDER_PROCS)
                    .withProcedureName("get_offender_image")
                    .withNamedBinding()
                    .declareParameters(
                            new SqlParameter(StoreProcMetadata.P_NOMS_ID, Types.VARCHAR),
                            new SqlOutParameter(P_IMAGE, Types.BLOB));
            compile();
        }
    }

}

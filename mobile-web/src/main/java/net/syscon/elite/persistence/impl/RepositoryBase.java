package net.syscon.elite.persistence.impl;


import net.syscon.elite.exception.EliteRuntimeException;
import net.syscon.elite.security.UserSecurityUtils;
import net.syscon.util.SQLProvider;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.core.io.Resource;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcOperations;

import java.io.IOException;


public class RepositoryBase implements ApplicationContextAware {

	private final Logger log = LoggerFactory.getLogger(getClass());

	protected NamedParameterJdbcOperations jdbcTemplate;
	protected SQLProvider sqlProvider;



	// TODO: Remove UserRepository dependency using SQLFilter approach to generate the filter
	//************************** PLEASE, FIX ME LATER!!! **************************
	protected String getCurrentCaseLoad() {
		final String username = UserSecurityUtils.getCurrentUsername();
		final String sql = "SELECT ASSIGNED_CASELOAD_ID FROM STAFF_MEMBERS WHERE PERSONNEL_TYPE = 'STAFF' AND USER_ID = :username";
		return jdbcTemplate.queryForObject(sql, createParams("username", username), String.class);
	}
	//********************************************************************************



	@Override
	public void setApplicationContext(final ApplicationContext applicationContext) {
		jdbcTemplate = applicationContext.getBean(NamedParameterJdbcOperations.class);
		final String resourcePath = "classpath:sqls/" + getClass().getSimpleName().replace('.', '/') + ".sql";
		final Resource resource = applicationContext.getResource(resourcePath);
		this.sqlProvider = new SQLProvider();
		try {
			sqlProvider.loadFromStream(resource.getInputStream());
		} catch (final IOException ex) {
			log.error(ex.getMessage(), ex);
		}
	}


	public MapSqlParameterSource createParams(final Object ... keysValues) {
		if (keysValues.length %2 != 0) throw new IllegalArgumentException("The keysValues must always be in pairs");
		final MapSqlParameterSource params = new MapSqlParameterSource();
		for (int i = 0; i < keysValues.length / 2; i++) {
			final int j = i * 2;
			params.addValue(keysValues[j].toString(), keysValues[j + 1]);
		}
		return params;
	}

	public String getPagedQuery(final String name) {
		final StringBuilder sb = new StringBuilder();
		String sql = sqlProvider.get(name);
		int i = sql.toUpperCase().indexOf("SELECT");
		if (i < 0) {
			throw new EliteRuntimeException("Paged Query must have a SELECT statement!");
		}

		sb.append(sql.substring(0, i + 6));
		sb.append(" COUNT(*) OVER() TOTAL, ");
		sb.append(sql.substring(i + 7));


		if (sb.length() > 0) {
			sb.append(" OFFSET :offset ROWS FETCH NEXT :limit ROWS ONLY");
		}
		return sb.toString();
	}

	public String getQuery(final String name) {
		return sqlProvider.get(name);
	}


}

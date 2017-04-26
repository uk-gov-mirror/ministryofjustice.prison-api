package net.syscon.elite.persistence.impl;

import jersey.repackaged.com.google.common.collect.ImmutableMap;
import net.syscon.elite.persistence.AgencyRepository;
import net.syscon.elite.persistence.mapping.FieldMapper;
import net.syscon.elite.persistence.mapping.Row2BeanRowMapper;
import net.syscon.elite.web.api.model.Agency;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class AgencyRepositoryImpl extends RepositoryBase implements AgencyRepository {

	private final Map<String, FieldMapper> agencyMapping = new ImmutableMap.Builder<String, FieldMapper>()
		.put("ID", 						new FieldMapper("uid"))
		.put("AGY_LOC_ID", 				new FieldMapper("agencyId"))
		.put("DESCRIPTION", 			new FieldMapper("description"))
		.put("AGENCY_LOCATION_TYPE", 	new FieldMapper("agencyType")).build();

	@Override
	public Agency find(String agencyId) {
		String sql = getQuery("FIND_AGENCY");
		RowMapper<Agency> agencyRowMapper = Row2BeanRowMapper.makeMapping(sql, Agency.class, agencyMapping);
		return jdbcTemplate.queryForObject(sql, createParams("agencyId", agencyId), agencyRowMapper);
	}

	@Override
	public List<Agency> findAgencies(int offset, int limit) {
		String sql = getPagedQuery("FIND_ALL_AGENCIES");
		RowMapper<Agency> agencyRowMapper = Row2BeanRowMapper.makeMapping(sql, Agency.class, agencyMapping);
		return jdbcTemplate.query(sql, createParams("offset", offset, "limit", limit), agencyRowMapper);
	}
}


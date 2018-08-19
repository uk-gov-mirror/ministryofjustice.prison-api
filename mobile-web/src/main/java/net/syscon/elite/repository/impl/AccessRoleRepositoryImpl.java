package net.syscon.elite.repository.impl;

import net.syscon.elite.api.model.AccessRole;
import net.syscon.elite.repository.AccessRoleRepository;
import net.syscon.elite.repository.mapping.StandardBeanPropertyRowMapper;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Repository;

import java.util.Objects;
import java.util.Optional;

@Repository
public class AccessRoleRepositoryImpl extends RepositoryBase implements AccessRoleRepository {

	private static final StandardBeanPropertyRowMapper<AccessRole> ACCESS_ROLE_ROW_MAPPER =
			new StandardBeanPropertyRowMapper<>(AccessRole.class);


	@Override
	public void createAccessRole(AccessRole accessRole) {

		jdbcTemplate.update(
				getQuery("INSERT_ACCESS_ROLE"),
				createParams("roleCode", accessRole.getRoleCode(), "roleName", accessRole.getRoleName(), "parentRoleCode", accessRole.getParentRoleCode()));
	}

	@Override
	public void updateAccessRole(AccessRole accessRole) {

		jdbcTemplate.update(
				getQuery("UPDATE_ACCESS_ROLE"),
				createParams("roleCode", accessRole.getRoleCode(), "roleName", accessRole.getRoleName()));
	}

	@Override
	public Optional<AccessRole> getAccessRole(String accessRoleCode) {
		Objects.requireNonNull(accessRoleCode, "Access role code is a required parameter");
		AccessRole accessRole;
		try {
			accessRole = jdbcTemplate.queryForObject(
					getQuery("GET_ACCESS_ROLE"),
					createParams("roleCode", accessRoleCode),
					ACCESS_ROLE_ROW_MAPPER);
		} catch (EmptyResultDataAccessException ex) {
			accessRole = null;
		}
		return Optional.ofNullable(accessRole);
	}
}
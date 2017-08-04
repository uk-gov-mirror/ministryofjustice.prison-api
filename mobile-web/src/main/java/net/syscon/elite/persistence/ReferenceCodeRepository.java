package net.syscon.elite.persistence;

import net.syscon.elite.web.api.model.CaseNoteType;
import net.syscon.elite.web.api.model.ReferenceCode;
import net.syscon.elite.web.api.resource.ReferenceDomainsResource.Order;

import java.util.List;
import java.util.Optional;

public interface ReferenceCodeRepository {

	Optional<ReferenceCode> getReferenceCodeByDomainAndCode(String domain, String code);
	Optional<ReferenceCode> getReferenceCodeByDomainAndParentAndCode(String domain, String code, String parentCode);
	List<ReferenceCode> getReferenceCodesByDomain(String domain, String query, String orderBy, Order order, int offset, int limit);
	List<ReferenceCode> getReferenceCodesByDomainAndParent(String domain, String parentCode, String query, String orderBy, Order order, int offset, int limit);
	List<CaseNoteType> getCaseNoteTypeByCurrentCaseLoad(String query, String orderBy, String order, int offset, int limit);
	List<CaseNoteType> getCaseNoteSubType(String typeCode, String query, String orderBy, String order, int offset, int limit);
}


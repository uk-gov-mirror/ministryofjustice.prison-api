package net.syscon.elite.service.impl;

import net.syscon.elite.persistence.CaseLoadRepository;
import net.syscon.elite.persistence.InmateRepository;
import net.syscon.elite.security.UserSecurityUtils;
import net.syscon.elite.service.EntityNotFoundException;
import net.syscon.elite.service.InmateService;
import net.syscon.elite.service.PrisonerDetailSearchCriteria;
import net.syscon.elite.v2.api.model.OffenderBooking;
import net.syscon.elite.v2.api.model.PrisonerDetail;
import net.syscon.elite.web.api.model.*;
import net.syscon.elite.web.api.resource.BookingResource.Order;
import net.syscon.elite.web.api.resource.LocationsResource;
import net.syscon.util.CalcDateRanges;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import static java.lang.String.format;

@Service
@Transactional(readOnly = true)
public class InmateServiceImpl implements InmateService {
    static final String DEFAULT_OFFENDER_SORT = "lastName,firstName,offenderNo";

    private final InmateRepository repository;
    private final CaseLoadRepository caseLoadRepository;
    private final int maxYears;

    @Autowired
    public InmateServiceImpl(InmateRepository repository, CaseLoadRepository caseLoadRepository, @Value("${offender.dob.max.range.years:10}") int maxYears) {
        this.repository = repository;
        this.caseLoadRepository = caseLoadRepository;
        this.maxYears = maxYears;
    }

    @Override
    public List<AssignedInmate> findAllInmates(String query, int offset, int limit, String orderBy, Order order) {
        String colSort = StringUtils.isNotBlank(orderBy) ? orderBy : DEFAULT_OFFENDER_SORT;
        return repository.findAllInmates(query, offset, limit, colSort, order);
    }

    @Override
    public List<AssignedInmate> findInmatesByLocation(Long locationId, String query, String orderByField, LocationsResource.Order order, int offset, int limit) {
        String colSort = StringUtils.isNotBlank(orderByField) ? orderByField : DEFAULT_OFFENDER_SORT;
        return repository.findInmatesByLocation(locationId, query, colSort, order, offset, limit);
    }

    @Override
    public InmateDetails findInmate(Long inmateId) {
        return repository.findInmate(inmateId).orElseThrow(new EntityNotFoundException(String.valueOf(inmateId)));
    }

    @Override
    public List<Alias> findInmateAliases(Long inmateId, String orderByField, Order order) {
        return repository.findInmateAliases(inmateId, orderByField, order);
    }

    @Override
    public List<InmateAssignmentSummary> findMyAssignments(long staffId, String currentCaseLoad, int offset, int limit) {
        return repository.findMyAssignments(staffId, currentCaseLoad, DEFAULT_OFFENDER_SORT, true, offset, limit);
    }

    @Override
    public List<OffenderBooking> findOffenders(String keywords, String locationId, String sortFields, String sortOrder, Long offset, Long limit) {

        final Set<String> caseloads = caseLoadRepository.findCaseLoadsByUsername(UserSecurityUtils.getCurrentUsername()).stream().map(CaseLoad::getCaseLoadId).collect(Collectors.toSet());
        final boolean descendingOrder = StringUtils.equalsIgnoreCase(sortOrder, "desc");
        return repository.searchForOffenderBookings(caseloads, keywords, locationId,
                offset != null ? offset.intValue() : 0,
                limit != null ? limit.intValue() : Integer.MAX_VALUE, StringUtils.isNotBlank(sortFields) ? sortFields : DEFAULT_OFFENDER_SORT, !descendingOrder);
    }

    @Override
    public List<PrisonerDetail> findPrisoners(PrisonerDetailSearchCriteria criteria, String sortFields, Long limit) {
        final String query = generateQuery(criteria);
        CalcDateRanges calcDates = new CalcDateRanges(criteria.getDob(), criteria.getDobFrom(), criteria.getDobTo(), maxYears);
        if (query != null || calcDates.hasDobRange()) {
            long rowLimit = (limit != null ? limit : 50L);
            return repository.searchForOffenders(query, calcDates.getDobDateFrom(), calcDates.getDobDateTo(),
                    StringUtils.isNotBlank(sortFields) ? sortFields : DEFAULT_OFFENDER_SORT, true, rowLimit);
        }
        return null;
    }

    private String generateQuery(PrisonerDetailSearchCriteria criteria) {
        final StringBuilder query = new StringBuilder();

        if (StringUtils.isNotBlank(criteria.getFirstName())) {
            query.append(format("firstName:like:'%s%%'", criteria.getFirstName()));
        }
        if (StringUtils.isNotBlank(criteria.getMiddleNames())) {
            addAnd(query);
            query.append(format("middleName:like:'%s%%'", criteria.getMiddleNames()));
        }
        if (StringUtils.isNotBlank(criteria.getLastName())) {
            addAnd(query);
            query.append(format("lastName:like:'%s%%'", criteria.getLastName()));
        }
        if (StringUtils.isNotBlank(criteria.getPncNumber())) {
            addAnd(query);
            query.append(format("pncNumber:eq:'%s'", criteria.getPncNumber()));
        }
        if (StringUtils.isNotBlank(criteria.getCroNumber())) {
            addAnd(query);
            query.append(format("croNumber:eq:'%s'", criteria.getCroNumber()));
        }
        return StringUtils.trimToNull(query.toString());
    }

    private void addAnd(StringBuilder query) {
        if (query.length() > 0) {
            query.append(",and:");
        }
    }


}

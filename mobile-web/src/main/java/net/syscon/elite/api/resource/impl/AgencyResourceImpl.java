package net.syscon.elite.api.resource.impl;

import net.syscon.elite.api.model.Agency;
import net.syscon.elite.api.resource.AgencyResource;
import net.syscon.elite.api.support.Page;
import net.syscon.elite.core.RestResource;
import net.syscon.elite.service.AgencyService;

import javax.ws.rs.Path;

import static net.syscon.util.ResourceUtils.nvl;

@RestResource
@Path("/agencies")
public class AgencyResourceImpl implements AgencyResource {
    private final AgencyService agencyService;

    public AgencyResourceImpl(AgencyService agencyService) {
        this.agencyService = agencyService;
    }

    @Override
    public GetAgenciesResponse getAgencies(Long pageOffset, Long pageLimit) {
        Page<Agency> agencies = agencyService.getAgencies(nvl(pageOffset, 0L), nvl(pageLimit, 10L));

        return GetAgenciesResponse.respond200WithApplicationJson(agencies);
    }

    @Override
    public GetAgencyResponse getAgency(String agencyId) {
        Agency agency = agencyService.getAgency(agencyId);

        return GetAgencyResponse.respond200WithApplicationJson(agency);
    }
}
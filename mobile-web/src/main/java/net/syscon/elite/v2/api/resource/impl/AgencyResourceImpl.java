package net.syscon.elite.v2.api.resource.impl;

import net.syscon.elite.core.RestResource;
import net.syscon.elite.service.AgencyLocationService;
import net.syscon.elite.v2.api.model.Agency;
import net.syscon.elite.v2.api.model.AgencyImpl;
import net.syscon.elite.v2.api.resource.AgencyResource;
import org.springframework.beans.factory.annotation.Autowired;

import javax.ws.rs.Path;
import java.util.ArrayList;
import java.util.List;

@RestResource
@Path("v2/agencies")
public class AgencyResourceImpl implements AgencyResource {

    @Autowired
    private AgencyLocationService agencyLocationService;

    @Override
    public GetAgenciesResponse getAgencies(Long offset, Long limit) {
        final List<net.syscon.elite.web.api.model.Agency> agencies =
                agencyLocationService.getAgencies(offset != null ? offset.intValue() : 0, limit != null ? limit.intValue() : 10);

        return GetAgenciesResponse.respond200WithApplicationJson(convertAgencies(agencies));
    }

    @Override
    public GetAgencyResponse getAgency(String agencyId) {
        return GetAgencyResponse.respond200WithApplicationJson(convertAgency(agencyLocationService.getAgency(agencyId)));
    }

    @Override
    public GetAgencyLocationsResponse getAgencyLocations(String agencyId, Long offset, Long limit) {
        return GetAgencyLocationsResponse.respond200WithApplicationJson(new ArrayList<>());
    }

    private List<Agency> convertAgencies(List<net.syscon.elite.web.api.model.Agency> inList) {
        List<Agency> outList = new ArrayList<>();

        if (inList != null) {
            for (net.syscon.elite.web.api.model.Agency agency : inList) {
                outList.add(convertAgency(agency));
            }
        }

        return outList;
    }

    private Agency convertAgency(net.syscon.elite.web.api.model.Agency inData) {
        Agency outData;

        if (inData == null) {
            outData = null;
        } else {
            outData = new AgencyImpl();

            outData.setAgencyId(inData.getAgencyId());
            outData.setDescription(inData.getDescription());
            outData.setAgencyType(inData.getAgencyType());
        }

        return outData;
    }
}
package net.syscon.elite.executableSpecification.steps;

import com.google.common.collect.ImmutableMap;
import net.syscon.elite.v2.api.model.OffenderBooking;
import net.syscon.elite.web.api.model.PageMetaData;
import net.thucydides.core.annotations.Step;
import org.apache.commons.lang3.StringUtils;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

/**
 * BDD step implementations for Offender search feature.
 */
public class OffenderSearchSteps extends CommonSteps {
    private static final String LOCATION_SEARCH = V2_API_PREFIX + "search-offenders/%s";
    private static final String LOCATION_KEYWORD_SEARCH = V2_API_PREFIX + "search-offenders/%s/%s";

    private List<OffenderBooking> offenderBookings;

    @Step("Perform offender search without any criteria")
    public void findAll() {
        search(null, null);
    }

    @Step("Verify first names of offender returned by search")
    public void verifyFirstNames(String nameList) {
        verifyPropertyValues(offenderBookings, OffenderBooking::getFirstName, nameList);
    }

    @Step("Verify middle names of offender returned by search")
    public void verifyMiddleNames(String nameList) {
        verifyPropertyValues(offenderBookings, OffenderBooking::getMiddleName, nameList);
    }

    @Step("Verify last names of offender returned by search")
    public void verifyLastNames(String nameList) {
        verifyPropertyValues(offenderBookings, OffenderBooking::getLastName, nameList);
    }

    @Step("Verify living unit of offender returned by search")
    public void verifyLivingUnits(String livingUnitList) {
        verifyPropertyValues(offenderBookings, OffenderBooking::getAssignedLivingUnitDesc, livingUnitList);
    }


    public void search(String locationPrefix, String keywords) {
        init();
        String queryUrl;
        if (StringUtils.isNotBlank(keywords)) {
            queryUrl = String.format(LOCATION_KEYWORD_SEARCH, StringUtils.isNotBlank(locationPrefix) ? locationPrefix.trim() : "_", keywords.trim());
        } else {
            queryUrl = String.format(LOCATION_SEARCH, StringUtils.isNotBlank(locationPrefix) ? locationPrefix.trim() : "_");
        }
        final ImmutableMap<String, String> inputHeaders = ImmutableMap.of("Page-Offset", "0", "Page-Limit", "10");


        ResponseEntity<List<OffenderBooking>> responseEntity = restTemplate.exchange(queryUrl,
                HttpMethod.GET, createEntity(null, inputHeaders), new ParameterizedTypeReference<List<OffenderBooking>>() {});

        assertThat(responseEntity.getStatusCode()).isEqualTo(HttpStatus.OK);

        final HttpHeaders headers = responseEntity.getHeaders();
        final Long totalRecords = Long.valueOf(headers.get("Total-Records").get(0));
        final Long offset = Long.valueOf(headers.get("Page-Offset").get(0));
        final Long limit = Long.valueOf(headers.get("Page-Limit").get(0));
        offenderBookings = responseEntity.getBody();
        setResourceMetaData(offenderBookings, new PageMetaData(offset, limit, totalRecords, "search-offenders"));
    }


}
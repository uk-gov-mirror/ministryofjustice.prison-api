package uk.gov.justice.hmpps.prison.service;

import org.springframework.stereotype.Component;
import uk.gov.justice.hmpps.prison.api.model.AddressDto;
import uk.gov.justice.hmpps.prison.api.model.AddressUsageDto;
import uk.gov.justice.hmpps.prison.api.model.Telephone;
import uk.gov.justice.hmpps.prison.repository.jpa.model.Address;
import uk.gov.justice.hmpps.prison.repository.jpa.model.Phone;

import java.util.List;
import java.util.stream.Collectors;

import static java.util.stream.Collectors.toList;

@Component
public class AddressTransformer {

    public static List<AddressDto> translate(final List<? extends Address> addresses) {
        return addresses.stream().map(AddressTransformer::translate).collect(toList());
    }

    public static AddressDto translate(final Address address) {
        final var country = address.getCountry() != null ? address.getCountry().getDescription() : null;
        final var county = address.getCounty() != null ? address.getCounty().getDescription() : null;
        final var town = address.getCity() != null ? address.getCity().getDescription() : null;
        final var addressType = address.getAddressType() != null ? address.getAddressType().getDescription() : null;

        return AddressDto.builder()
                .addressId(address.getAddressId())
                .addressType(addressType)
                .flat(address.getFlat())
                .comment(address.getCommentText())
                .country(country)
                .county(county)
                .locality(address.getLocality())
                .town(town)
                .postalCode(address.getPostalCode())
                .noFixedAddress(address.getNoFixedAddressFlag().equals("Y"))
                .premise(address.getPremise())
                .primary(address.getPrimaryFlag().equals("Y"))
                .startDate(address.getStartDate())
                .endDate(address.getEndDate())
                .street(address.getStreet())
                .addressUsages(address.getAddressUsages().stream()
                        .map(addressUsage ->
                                AddressUsageDto.builder()
                                        .addressId(address.getAddressId())
                                        .activeFlag("Y".equalsIgnoreCase(addressUsage.getActiveFlag()))
                                        .addressUsage(addressUsage.getAddressUsage())
                                        .addressUsageDescription(addressUsage.getAddressUsageType() == null ? null : addressUsage.getAddressUsageType().getDescription())
                                        .build()).collect(Collectors.toList()))
                .phones(translatePhones(address.getPhones()))
                .build();
    }

    public static List<Telephone> translatePhones(final List<? extends Phone> phones) {
        return phones.stream().map(AddressTransformer::translate).collect(toList());
    }

    public static Telephone translate(final Phone phone) {
        return Telephone.builder()
            .phoneId(phone.getPhoneId())
            .ext(phone.getExtNo())
            .type(phone.getPhoneType())
            .number(phone.getPhoneNo())
            .build();
    }
}

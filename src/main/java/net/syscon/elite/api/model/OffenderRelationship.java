package net.syscon.elite.api.model;

import com.fasterxml.jackson.annotation.*;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import java.util.HashMap;
import java.util.Map;

/**
 * Offender Relationship
 **/
@SuppressWarnings("unused")
@ApiModel(description = "Offender Relationship")
@JsonInclude(JsonInclude.Include.NON_NULL)
@Builder
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode
public class OffenderRelationship {
    @JsonIgnore
    private Map<String, Object> additionalProperties;
    
    private Long personId;

    private String externalRef;

    @NotBlank
    private String lastName;

    @NotBlank
    private String firstName;

    @NotBlank
    private String relationshipType;

    @JsonAnyGetter
    public Map<String, Object> getAdditionalProperties() {
        return additionalProperties == null ? new HashMap<>() : additionalProperties;
    }

    @ApiModelProperty(hidden = true)
    @JsonAnySetter
    public void setAdditionalProperties(Map<String, Object> additionalProperties) {
        this.additionalProperties = additionalProperties;
    }

    /**
      * id of the person contact
      */
    @ApiModelProperty(value = "id of the person contact")
    @JsonProperty("personId")
    public Long getPersonId() {
        return personId;
    }

    public void setPersonId(Long personId) {
        this.personId = personId;
    }

    /**
      * unique external Id
      */
    @ApiModelProperty(value = "unique external Id")
    @JsonProperty("externalRef")
    public String getExternalRef() {
        return externalRef;
    }

    public void setExternalRef(String externalRef) {
        this.externalRef = externalRef;
    }

    /**
      * Surname
      */
    @ApiModelProperty(required = true, value = "Surname")
    @JsonProperty("lastName")
    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    /**
      * First Name
      */
    @ApiModelProperty(required = true, value = "First Name")
    @JsonProperty("firstName")
    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    /**
      * Relationship to inmate (e.g. COM or POM, etc.)
      */
    @ApiModelProperty(required = true, value = "Relationship to inmate (e.g. COM or POM, etc.)")
    @JsonProperty("relationshipType")
    public String getRelationshipType() {
        return relationshipType;
    }

    public void setRelationshipType(String relationshipType) {
        this.relationshipType = relationshipType;
    }

    @Override
    public String toString()  {
        StringBuilder sb = new StringBuilder();

        sb.append("class OffenderRelationship {\n");
        
        sb.append("  personId: ").append(personId).append("\n");
        sb.append("  externalRef: ").append(externalRef).append("\n");
        sb.append("  lastName: ").append(lastName).append("\n");
        sb.append("  firstName: ").append(firstName).append("\n");
        sb.append("  relationshipType: ").append(relationshipType).append("\n");
        sb.append("}\n");

        return sb.toString();
    }
}

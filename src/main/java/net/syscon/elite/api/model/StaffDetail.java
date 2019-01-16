package net.syscon.elite.api.model;

import com.fasterxml.jackson.annotation.*;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.HashMap;
import java.util.Map;

/**
 * Staff Details
 **/
@SuppressWarnings("unused")
@ApiModel(description = "Staff Details")
@JsonInclude(JsonInclude.Include.NON_NULL)
@Builder
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode
public class StaffDetail {
    @JsonIgnore
    private Map<String, Object> additionalProperties;
    
    @NotNull
    private Long staffId;

    @NotBlank
    private String firstName;

    @NotBlank
    private String lastName;

    @NotBlank
    private String status;

    private Long thumbnailId;

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
      * Unique identifier for staff member.
      */
    @ApiModelProperty(required = true, value = "Unique identifier for staff member.")
    @JsonProperty("staffId")
    public Long getStaffId() {
        return staffId;
    }

    public void setStaffId(Long staffId) {
        this.staffId = staffId;
    }

    /**
      * Staff member's first name.
      */
    @ApiModelProperty(required = true, value = "Staff member's first name.")
    @JsonProperty("firstName")
    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    /**
      * Staff member's last name.
      */
    @ApiModelProperty(required = true, value = "Staff member's last name.")
    @JsonProperty("lastName")
    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    /**
      * Status of staff member.
      */
    @ApiModelProperty(required = true, value = "Status of staff member.")
    @JsonProperty("status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    /**
      * Identifier for staff member image.
      */
    @ApiModelProperty(value = "Identifier for staff member image.")
    @JsonProperty("thumbnailId")
    public Long getThumbnailId() {
        return thumbnailId;
    }

    public void setThumbnailId(Long thumbnailId) {
        this.thumbnailId = thumbnailId;
    }

    @Override
    public String toString()  {
        StringBuilder sb = new StringBuilder();

        sb.append("class StaffDetail {\n");
        
        sb.append("  staffId: ").append(staffId).append("\n");
        sb.append("  firstName: ").append(firstName).append("\n");
        sb.append("  lastName: ").append(lastName).append("\n");
        sb.append("  status: ").append(status).append("\n");
        sb.append("  thumbnailId: ").append(thumbnailId).append("\n");
        sb.append("}\n");

        return sb.toString();
    }
}
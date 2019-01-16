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
 * Physical Characteristic
 **/
@SuppressWarnings("unused")
@ApiModel(description = "Physical Characteristic")
@JsonInclude(JsonInclude.Include.NON_NULL)
@Builder
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode
public class PhysicalCharacteristic {
    @JsonIgnore
    private Map<String, Object> additionalProperties;
    
    @NotBlank
    private String type;

    @NotBlank
    private String characteristic;

    @NotBlank
    private String detail;

    private Long imageId;

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
      * Type code of physical characteristic
      */
    @ApiModelProperty(required = true, value = "Type code of physical characteristic")
    @JsonProperty("type")
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    /**
      * Type of physical characteristic
      */
    @ApiModelProperty(required = true, value = "Type of physical characteristic")
    @JsonProperty("characteristic")
    public String getCharacteristic() {
        return characteristic;
    }

    public void setCharacteristic(String characteristic) {
        this.characteristic = characteristic;
    }

    /**
      * Detailed information about the physical characteristic
      */
    @ApiModelProperty(required = true, value = "Detailed information about the physical characteristic")
    @JsonProperty("detail")
    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    /**
      * Image Id Ref
      */
    @ApiModelProperty(value = "Image Id Ref")
    @JsonProperty("imageId")
    public Long getImageId() {
        return imageId;
    }

    public void setImageId(Long imageId) {
        this.imageId = imageId;
    }

    @Override
    public String toString()  {
        StringBuilder sb = new StringBuilder();

        sb.append("class PhysicalCharacteristic {\n");
        
        sb.append("  type: ").append(type).append("\n");
        sb.append("  characteristic: ").append(characteristic).append("\n");
        sb.append("  detail: ").append(detail).append("\n");
        sb.append("  imageId: ").append(imageId).append("\n");
        sb.append("}\n");

        return sb.toString();
    }
}
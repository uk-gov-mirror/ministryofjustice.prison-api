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
 * Telephone Details
 **/
@SuppressWarnings("unused")
@ApiModel(description = "Telephone Details")
@JsonInclude(JsonInclude.Include.NON_NULL)
@Builder
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode
public class Telephone {
    @JsonIgnore
    private Map<String, Object> additionalProperties;
    
    @NotBlank
    private String number;

    @NotBlank
    private String type;

    private String ext;

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
      * Telephone number
      */
    @ApiModelProperty(required = true, value = "Telephone number")
    @JsonProperty("number")
    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    /**
      * Telephone type
      */
    @ApiModelProperty(required = true, value = "Telephone type")
    @JsonProperty("type")
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    /**
      * Telephone extention number
      */
    @ApiModelProperty(value = "Telephone extention number")
    @JsonProperty("ext")
    public String getExt() {
        return ext;
    }

    public void setExt(String ext) {
        this.ext = ext;
    }

    @Override
    public String toString()  {
        StringBuilder sb = new StringBuilder();

        sb.append("class Telephone {\n");
        
        sb.append("  number: ").append(number).append("\n");
        sb.append("  type: ").append(type).append("\n");
        sb.append("  ext: ").append(ext).append("\n");
        sb.append("}\n");

        return sb.toString();
    }
}
package net.syscon.elite.api.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;
import java.util.Map;

/**
 * Case Note Amendment
 **/
@SuppressWarnings("unused")
@ApiModel(description = "Case Note Amendment")
@JsonInclude(JsonInclude.Include.NON_NULL)
@Builder
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode
@Data
public class CaseNoteAmendment {
    @ApiModelProperty(required = true, value = "Date and Time of Case Note creation", example = "2018-12-01T13:45:00")
    @NotNull
    private LocalDateTime creationDateTime;

    @ApiModelProperty(required = true, value = "Name of the user amending the case note (lastname, firstname)", position = 1, example = "Smith, John")
    @NotBlank
    private String authorName;

    @ApiModelProperty(required = true, value = "Additional Case Note Information", position = 2, example = "Some Additional Text")
    @NotBlank
    private String additionalNoteText;

    @JsonIgnore
    private Map<String, Object> additionalProperties;

}
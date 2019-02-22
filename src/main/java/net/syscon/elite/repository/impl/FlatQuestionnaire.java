package net.syscon.elite.repository.impl;

import lombok.*;

import java.time.LocalDateTime;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode
@Data
@ToString
class FlatQuestionnaire {

    private String code;
    private Long questionnaireId;
    private Long questionnaireQueId;
    private int questionSeq;
    private String questionDesc;
    private int answerSeq;
    private String answerDesc;
    private int questionListSeq;
    private Boolean questionActiveFlag;
    private LocalDateTime questionExpiryDate;
    private Boolean multipleAnswerFlag;
    private Long questionnaireAnsId;
    private Long nextQuestionnaireQueId;
    private int answerListSeq;
    private Boolean answerActiveFlag;
    private LocalDateTime answerExpiryDate;
    private Boolean dateRequiredFlag;
    private Boolean commentRequiredFlag;

}
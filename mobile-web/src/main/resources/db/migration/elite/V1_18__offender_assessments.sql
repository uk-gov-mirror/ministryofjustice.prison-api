CREATE TABLE OFFENDER_ASSESSMENTS
(
  "OFFENDER_BOOK_ID"              NUMBER(10, 0),
  "ASSESSMENT_SEQ"                NUMBER(6, 0),
  "ASSESSMENT_DATE"               DATE,
  "ASSESSMENT_TYPE_ID"            NUMBER(10, 0),
  "SCORE"                         NUMBER(6, 2),
  "ASSESS_STATUS"                 VARCHAR2(12 CHAR),
  "CALC_SUP_LEVEL_TYPE"           VARCHAR2(12 CHAR),
  "ASSESS_STAFF_ID"               NUMBER(6, 0),
  "ASSESS_COMMENT_TEXT"           VARCHAR2(4000 CHAR),
  "OVERRIDE_REASON_TEXT"          VARCHAR2(40 CHAR),
  "PLACE_AGY_LOC_ID"              VARCHAR2(6 CHAR),
  "OVERRIDED_SUP_LEVEL_TYPE"      VARCHAR2(12 CHAR),
  "OVERRIDE_COMMENT_TEXT"         VARCHAR2(240 CHAR),
  "OVERRIDE_STAFF_ID"             NUMBER(6, 0),
  "EVALUATION_DATE"               DATE,
  "NEXT_REVIEW_DATE"              DATE,
  "EVALUATION_RESULT_CODE"        VARCHAR2(12 CHAR),
  "REVIEW_SUP_LEVEL_TYPE"         VARCHAR2(12 CHAR),
  "REVIEW_PLACEMENT_TEXT"         VARCHAR2(240 CHAR),
  "REVIEW_COMMITTE_CODE"          VARCHAR2(12 CHAR),
  "COMMITTE_COMMENT_TEXT"         VARCHAR2(240 CHAR),
  "REVIEW_PLACE_AGY_LOC_ID"       VARCHAR2(6 CHAR),
  "REVIEW_SUP_LEVEL_TEXT"         VARCHAR2(240 CHAR),
  "MODIFY_USER_ID"                VARCHAR2(32 CHAR),
  "ASSESS_COMMITTE_CODE"          VARCHAR2(12 CHAR),
  "CREATION_DATE"                 DATE,
  "CREATION_USER"                 VARCHAR2(32 CHAR),
  "APPROVED_SUP_LEVEL_TYPE"       VARCHAR2(12 CHAR),
  "ASSESSMENT_CREATE_LOCATION"    VARCHAR2(6 CHAR),
  "ASSESSOR_STAFF_ID"             NUMBER(6, 0),
  "MODIFY_DATETIME"               TIMESTAMP(9),
  "OVERRIDE_USER_ID"              VARCHAR2(32 CHAR),
  "OVERRIDE_REASON"               VARCHAR2(12 CHAR),
  "CREATE_DATETIME"               TIMESTAMP(9)      DEFAULT systimestamp,
  "CREATE_USER_ID"                VARCHAR2(32 CHAR) DEFAULT USER,
  "SEAL_FLAG"                     VARCHAR2(1 CHAR)
);
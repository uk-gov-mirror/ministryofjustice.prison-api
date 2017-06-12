CREATE SEQUENCE OFFENDER_ID START WITH 1 NOCYCLE;
CREATE SEQUENCE OFFENDER_BOOK_ID START WITH 1 NOCYCLE;

CREATE TABLE OFFENDERS
(
  "OFFENDER_ID"                   NUMBER(10, 0),
  "OFFENDER_NAME_SEQ"             NUMBER(12, 0),
  "ID_SOURCE_CODE"                VARCHAR2(12 CHAR),
  "LAST_NAME"                     VARCHAR2(35 CHAR),
  "NAME_TYPE"                     VARCHAR2(12 CHAR),
  "FIRST_NAME"                    VARCHAR2(35 CHAR),
  "MIDDLE_NAME"                   VARCHAR2(35 CHAR),
  "BIRTH_DATE"                    DATE,
  "SEX_CODE"                      VARCHAR2(12 CHAR),
  "SUFFIX"                        VARCHAR2(12 CHAR),
  "LAST_NAME_SOUNDEX"             VARCHAR2(6 CHAR),
  "BIRTH_PLACE"                   VARCHAR2(25 CHAR),
  "BIRTH_COUNTRY_CODE"            VARCHAR2(12 CHAR),
  "CREATE_DATE"                   DATE,
  "LAST_NAME_KEY"                 VARCHAR2(35 CHAR),
  "ALIAS_OFFENDER_ID"             NUMBER(10, 0),
  "FIRST_NAME_KEY"                VARCHAR2(35 CHAR),
  "MIDDLE_NAME_KEY"               VARCHAR2(35 CHAR),
  "OFFENDER_ID_DISPLAY"           VARCHAR2(10 CHAR),
  "ROOT_OFFENDER_ID"              NUMBER(10, 0),
  "CASELOAD_TYPE"                 VARCHAR2(12 CHAR),
  "MODIFY_USER_ID"                VARCHAR2(32 CHAR),
  "MODIFY_DATETIME"               TIMESTAMP(9),
  "ALIAS_NAME_TYPE"               VARCHAR2(12 CHAR),
  "PARENT_OFFENDER_ID"            NUMBER(10, 0),
  "UNIQUE_OBLIGATION_FLAG"        VARCHAR2(1 CHAR)  DEFAULT NULL,
  "SUSPENDED_FLAG"                VARCHAR2(1 CHAR)  DEFAULT NULL,
  "SUSPENDED_DATE"                DATE,
  "RACE_CODE"                     VARCHAR2(12 CHAR),
  "REMARK_CODE"                   VARCHAR2(12 CHAR),
  "ADD_INFO_CODE"                 VARCHAR2(12 CHAR),
  "BIRTH_COUNTY"                  VARCHAR2(20 CHAR),
  "BIRTH_STATE"                   VARCHAR2(20 CHAR),
  "MIDDLE_NAME_2"                 VARCHAR2(35 CHAR),
  "TITLE"                         VARCHAR2(12 CHAR),
  "AGE"                           NUMBER(3, 0),
  "CREATE_USER_ID"                VARCHAR2(32 CHAR) DEFAULT USER,
  "LAST_NAME_ALPHA_KEY"           VARCHAR2(1 CHAR)  DEFAULT NULL,
  "CREATE_DATETIME"               TIMESTAMP(9)      DEFAULT systimestamp,
  "NAME_SEQUENCE"                 VARCHAR2(12 CHAR),
  "SEAL_FLAG"                     VARCHAR2(1 CHAR)
);


CREATE TABLE OFFENDER_BOOKINGS
(
  "OFFENDER_BOOK_ID"              NUMBER(10, 0),
  "BOOKING_BEGIN_DATE"            DATE,
  "BOOKING_END_DATE"              DATE,
  "BOOKING_NO"                    VARCHAR2(14 CHAR),
  "OFFENDER_ID"                   NUMBER(10, 0),
  "AGY_LOC_ID"                    VARCHAR2(6 CHAR),
  "LIVING_UNIT_ID"                NUMBER(10, 0),
  "DISCLOSURE_FLAG"               VARCHAR2(1 CHAR)  DEFAULT 'Y',
  "IN_OUT_STATUS"                 VARCHAR2(12 CHAR),
  "ACTIVE_FLAG"                   VARCHAR2(1 CHAR)  DEFAULT 'N',
  "BOOKING_STATUS"                VARCHAR2(12 CHAR),
  "YOUTH_ADULT_CODE"              VARCHAR2(12 CHAR),
  "FINGER_PRINTED_STAFF_ID"       NUMBER(6, 0),
  "SEARCH_STAFF_ID"               NUMBER(6, 0),
  "PHOTO_TAKING_STAFF_ID"         NUMBER(6, 0),
  "ASSIGNED_STAFF_ID"             NUMBER(6, 0),
  "CREATE_AGY_LOC_ID"             VARCHAR2(6 CHAR),
  "BOOKING_TYPE"                  VARCHAR2(12 CHAR),
  "BOOKING_CREATED_DATE"          DATE,
  "ROOT_OFFENDER_ID"              NUMBER(10, 0),
  "AGENCY_IML_ID"                 NUMBER(10, 0),
  "SERVICE_FEE_FLAG"              VARCHAR2(1 CHAR)  DEFAULT 'N',
  "EARNED_CREDIT_LEVEL"           VARCHAR2(12 CHAR),
  "EKSTRAND_CREDIT_LEVEL"         VARCHAR2(12 CHAR),
  "INTAKE_AGY_LOC_ID"             VARCHAR2(6 CHAR),
  "ACTIVITY_DATE"                 DATE,
  "INTAKE_CASELOAD_ID"            VARCHAR2(6 CHAR),
  "INTAKE_USER_ID"                VARCHAR2(32 CHAR),
  "CASE_OFFICER_ID"               NUMBER(6, 0),
  "CASE_DATE"                     DATE,
  "CASE_TIME"                     DATE,
  "COMMUNITY_ACTIVE_FLAG"         VARCHAR2(1 CHAR)  DEFAULT 'N',
  "CREATE_INTAKE_AGY_LOC_ID"      VARCHAR2(6 CHAR),
  "COMM_STAFF_ID"                 NUMBER(6, 0),
  "COMM_STATUS"                   VARCHAR2(12 CHAR),
  "COMMUNITY_AGY_LOC_ID"          VARCHAR2(6 CHAR),
  "NO_COMM_AGY_LOC_ID"            NUMBER(6, 0),
  "COMM_STAFF_ROLE"               VARCHAR2(12 CHAR),
  "AGY_LOC_ID_LIST"               VARCHAR2(80 CHAR),
  "STATUS_REASON"                 VARCHAR2(32 CHAR),
  "TOTAL_UNEXCUSED_ABSENCES"      NUMBER(6, 0),
  "REQUEST_NAME"                  VARCHAR2(240 CHAR),
  "RECORD_USER_ID"                VARCHAR2(30 CHAR),
  "INTAKE_AGY_LOC_ASSIGN_DATE"    DATE,
  "CREATE_DATETIME"               TIMESTAMP(9)      DEFAULT systimestamp,
  "CREATE_USER_ID"                VARCHAR2(32 CHAR) DEFAULT USER,
  "MODIFY_DATETIME"               TIMESTAMP(9),
  "MODIFY_USER_ID"                VARCHAR2(32 CHAR),
  "SEAL_FLAG"                     VARCHAR2(1 CHAR)
);


CREATE TABLE OFFENDER_PHYSICAL_ATTRIBUTES
(
  "OFFENDER_BOOK_ID"              NUMBER(10, 0),
  "ATTRIBUTE_SEQ"                 NUMBER(6, 0),
  "HEIGHT_FT"                     NUMBER(6, 0),
  "HEIGHT_IN"                     NUMBER(6, 0),
  "HEIGHT_CM"                     NUMBER(6, 0),
  "WEIGHT_LBS"                    NUMBER(6, 0),
  "WEIGHT_KG"                     NUMBER(6, 0),
  "CREATE_DATETIME"               TIMESTAMP(9)      DEFAULT systimestamp,
  "CREATE_USER_ID"                VARCHAR2(32 CHAR) DEFAULT USER,
  "MODIFY_DATETIME"               TIMESTAMP(9),
  "MODIFY_USER_ID"                VARCHAR2(32 CHAR),
  "SEAL_FLAG"                     VARCHAR2(1 CHAR)
);


CREATE TABLE OFFENDER_IDENTIFYING_MARKS
(
  "OFFENDER_BOOK_ID"              NUMBER(10, 0),
  "ID_MARK_SEQ"                   NUMBER(6, 0),
  "BODY_PART_CODE"                VARCHAR2(12 CHAR),
  "MARK_TYPE"                     VARCHAR2(12 CHAR),
  "SIDE_CODE"                     VARCHAR2(12 CHAR),
  "PART_ORIENTATION_CODE"         VARCHAR2(12 CHAR),
  "COMMENT_TEXT"                  VARCHAR2(240 CHAR),
  "CREATE_DATETIME"               TIMESTAMP(9)      DEFAULT systimestamp,
  "CREATE_USER_ID"                VARCHAR2(32 CHAR) DEFAULT USER,
  "MODIFY_DATETIME"               TIMESTAMP(9),
  "MODIFY_USER_ID"                VARCHAR2(32 CHAR),
);


CREATE TABLE OFFENDER_PROFILE_DETAILS
(
  "OFFENDER_BOOK_ID"              NUMBER(10, 0),
  "PROFILE_SEQ"                   NUMBER(6, 0),
  "PROFILE_TYPE"                  VARCHAR2(12 CHAR),
  "PROFILE_CODE"                  VARCHAR2(40 CHAR),
  "LIST_SEQ"                      NUMBER(6, 0),
  "COMMENT_TEXT"                  VARCHAR2(240 CHAR),
  "CASELOAD_TYPE"                 VARCHAR2(12 CHAR),
  "MODIFY_USER_ID"                VARCHAR2(32 CHAR),
  "MODIFY_DATETIME"               TIMESTAMP(9),
  "CREATE_DATETIME"               TIMESTAMP(9)      DEFAULT systimestamp,
  "CREATE_USER_ID"                VARCHAR2(32 CHAR) DEFAULT USER,
  "SEAL_FLAG"                     VARCHAR2(1 CHAR)
);


CREATE TABLE CASELOAD_AGENCY_LOCATIONS
(
  "CASELOAD_ID"                   VARCHAR2(6 CHAR),
  "AGY_LOC_ID"                    VARCHAR2(6 CHAR),
  "UPDATE_ALLOWED_FLAG"           VARCHAR2(1 CHAR)  DEFAULT 'Y',
  "CREATE_DATETIME"               TIMESTAMP(9)      DEFAULT systimestamp,
  "CREATE_USER_ID"                VARCHAR2(32 CHAR) DEFAULT USER,
  "MODIFY_DATETIME"               TIMESTAMP(9),
  "MODIFY_USER_ID"                VARCHAR2(32 CHAR),
  "SEAL_FLAG"                     VARCHAR2(1 CHAR)
);


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


CREATE TABLE ASSESSMENTS
(
  "ASSESSMENT_ID"                 NUMBER(10, 0),
  "ASSESSMENT_CLASS"              VARCHAR2(12 CHAR),
  "PARENT_ASSESSMENT_ID"          NUMBER(10, 0),
  "ASSESSMENT_CODE"               VARCHAR2(20 CHAR),
  "DESCRIPTION"                   VARCHAR2(300 CHAR),
  "LIST_SEQ"                      NUMBER(6, 0),
  "ACTIVE_FLAG"                   VARCHAR2(1 CHAR)  DEFAULT 'Y',
  "UPDATE_ALLOWED_FLAG"           VARCHAR2(1 CHAR)  DEFAULT 'Y',
  "EFFECTIVE_DATE"                DATE,
  "EXPIRY_DATE"                   DATE,
  "SCORE"                         NUMBER(6, 2),
  "MUTUAL_EXCLUSIVE_FLAG"         VARCHAR2(1 CHAR)  DEFAULT 'Y',
  "DETERMINE_SUP_LEVEL_FLAG"      VARCHAR2(1 CHAR)  DEFAULT 'Y',
  "REQUIRE_EVALUATION_FLAG"       VARCHAR2(1 CHAR)  DEFAULT 'Y',
  "REQUIRE_APPROVAL_FLAG"         VARCHAR2(1 CHAR)  DEFAULT 'Y',
  "REVIEW_CYCLE_DAYS"             NUMBER(3, 0),
  "CASELOAD_TYPE"                 VARCHAR2(12 CHAR),
  "REVIEW_FLAG"                   VARCHAR2(1 CHAR)  DEFAULT 'N',
  "ASSESS_COMMENT"                VARCHAR2(240 CHAR),
  "HIGH_VALUE"                    NUMBER(5, 2),
  "LOW_VALUE"                     NUMBER(5, 2),
  "SEARCH_CRITERIA_FLAG"          VARCHAR2(1 CHAR)  DEFAULT 'N',
  "OVERRIDEABLE_FLAG"             VARCHAR2(1 CHAR)  DEFAULT 'N',
  "ASSESSMENT_TYPE"               VARCHAR2(12 CHAR),
  "CALCULATE_TOTAL_FLAG"          VARCHAR2(1 CHAR)  DEFAULT 'N',
  "MEASURE"                       VARCHAR2(12 CHAR),
  "CREATE_USER_ID"                VARCHAR2(32 CHAR) DEFAULT USER,
  "CREATE_DATE"                   DATE,
  "MODIFY_USER_ID"                VARCHAR2(32 CHAR),
  "MODIFY_DATETIME"               TIMESTAMP(9),
  "CREATE_DATETIME"               TIMESTAMP(9)      DEFAULT systimestamp,
  "CELL_SHARING_ALERT_FLAG"       VARCHAR2(1 CHAR)  DEFAULT 'N',
  "TOTAL_PERCENT"                 NUMBER(6, 2),
  "SCREEN_CODE"                   VARCHAR2(40 CHAR),
	"SCHEDULE_COMPLETE_DAYS"        NUMBER(3, 0),
	"SECT_SCORE_INCLUDE_FLAG"       VARCHAR2(1 CHAR)  DEFAULT 'Y',
	"SECT_SCORE_OVERRIDE_FLAG"      VARCHAR2(1 CHAR)  DEFAULT 'N',
	"MEDICAL_FLAG"                  VARCHAR2(1 CHAR)  DEFAULT 'N',
  "SEAL_FLAG"                     VARCHAR2(1 CHAR)
);


CREATE TABLE PROFILE_TYPES
(
  "PROFILE_TYPE"                  VARCHAR2(12 CHAR),
  "PROFILE_CATEGORY"              VARCHAR2(12 CHAR),
  "DESCRIPTION"                   VARCHAR2(40 CHAR),
  "LIST_SEQ"                      NUMBER(6, 0),
  "MANDATORY_FLAG"                VARCHAR2(1 CHAR)  DEFAULT 'Y',
  "UPDATED_ALLOWED_FLAG"          VARCHAR2(1 CHAR)  DEFAULT 'Y',
  "CODE_VALUE_TYPE"               VARCHAR2(12 CHAR),
  "ACTIVE_FLAG"                   VARCHAR2(1 CHAR)  DEFAULT 'Y',
  "EXPIRY_DATE"                   DATE,
  "MODIFY_USER_ID"                VARCHAR2(32 CHAR),
  "MODIFIED_DATE"                 DATE,
  "CREATE_DATETIME"               TIMESTAMP(9)      DEFAULT systimestamp,
  "CREATE_USER_ID"                VARCHAR2(32 CHAR) DEFAULT USER,
  "MODIFY_DATETIME"               TIMESTAMP(9),
  "SEAL_FLAG"                     VARCHAR2(1 CHAR)
);


CREATE TABLE PROFILE_CODES
(
  "PROFILE_TYPE"                  VARCHAR2(12 CHAR),
  "PROFILE_CODE"                  VARCHAR2(12 CHAR),
  "DESCRIPTION"                   VARCHAR2(40 CHAR),
  "LIST_SEQ"                      NUMBER(6, 0),
  "UPDATE_ALLOWED_FLAG"           VARCHAR2(1 CHAR)  DEFAULT 'Y',
  "ACTIVE_FLAG"                   VARCHAR2(1 CHAR)  DEFAULT 'Y',
  "EXPIRY_DATE"                   DATE,
  "USER_ID"                       VARCHAR2(32 CHAR),
  "MODIFIED_DATE"                 DATE,
  "CREATE_DATETIME"               TIMESTAMP(9)      DEFAULT systimestamp,
  "CREATE_USER_ID"                VARCHAR2(32 CHAR) DEFAULT USER,
  "MODIFY_DATETIME"               TIMESTAMP(9),
  "MODIFY_USER_ID"                VARCHAR2(32 CHAR),
  "SEAL_FLAG"                     VARCHAR2(1 CHAR)
);
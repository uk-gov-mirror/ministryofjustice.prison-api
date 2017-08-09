CREATE TABLE ASSESSMENTS
(
  ASSESSMENT_ID                 DECIMAL(10, 0),
  ASSESSMENT_CLASS              VARCHAR(12),
  PARENT_ASSESSMENT_ID          DECIMAL(10, 0),
  ASSESSMENT_CODE               VARCHAR(20),
  DESCRIPTION                   VARCHAR(300),
  LIST_SEQ                      DECIMAL(6, 0),
  ACTIVE_FLAG                   VARCHAR(1)  DEFAULT 'Y',
  UPDATE_ALLOWED_FLAG           VARCHAR(1)  DEFAULT 'Y',
  EFFECTIVE_DATE                DATE,
  EXPIRY_DATE                   DATE,
  SCORE                         DECIMAL(8, 2),
  MUTUAL_EXCLUSIVE_FLAG         VARCHAR(1)  DEFAULT 'N',
  DETERMINE_SUP_LEVEL_FLAG      VARCHAR(1)  DEFAULT 'N',
  REQUIRE_EVALUATION_FLAG       VARCHAR(1)  DEFAULT 'N',
  REQUIRE_APPROVAL_FLAG         VARCHAR(1)  DEFAULT 'N',
  REVIEW_CYCLE_DAYS             DECIMAL(3, 0),
  CASELOAD_TYPE                 VARCHAR(12),
  REVIEW_FLAG                   VARCHAR(1)  DEFAULT 'N',
  ASSESS_COMMENT                VARCHAR(240),
  HIGH_VALUE                    DECIMAL(5, 2),
  LOW_VALUE                     DECIMAL(5, 2),
  SEARCH_CRITERIA_FLAG          VARCHAR(1)  DEFAULT 'N',
  OVERRIDEABLE_FLAG             VARCHAR(1)  DEFAULT 'N',
  ASSESSMENT_TYPE               VARCHAR(12),
  CALCULATE_TOTAL_FLAG          VARCHAR(1)  DEFAULT 'N',
  MEASURE                       VARCHAR(12),
  CREATE_USER_ID                VARCHAR(32) DEFAULT USER,
  CREATE_DATE                   DATE,
  MODIFY_USER_ID                VARCHAR(32),
  MODIFY_DATETIME               TIMESTAMP(6),
  CREATE_DATETIME               TIMESTAMP(6)      DEFAULT now(),
  CELL_SHARING_ALERT_FLAG       VARCHAR(1)  DEFAULT 'N',
  AUDIT_TIMESTAMP               TIMESTAMP(6),
  AUDIT_USER_ID                 VARCHAR(32),
  AUDIT_MODULE_NAME             VARCHAR(65),
  AUDIT_CLIENT_USER_ID          VARCHAR(64),
  AUDIT_CLIENT_IP_ADDRESS       VARCHAR(39),
  AUDIT_CLIENT_WORKSTATION_NAME VARCHAR(64),
  AUDIT_ADDITIONAL_INFO         VARCHAR(256),
  TOTAL_PERCENT                 DECIMAL(6, 2),
  REVERSE_SCORE                 DECIMAL(8, 2),
  SCREEN_CODE                   VARCHAR(40)
);
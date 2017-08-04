CREATE TABLE STAFF_MEMBERS
(
  STAFF_ID                      DECIMAL(10, 0) PRIMARY KEY,
  ASSIGNED_CASELOAD_ID          VARCHAR(6),
  WORKING_STOCK_LOC_ID          VARCHAR(6),
  WORKING_CASELOAD_ID           VARCHAR(6),
  USER_ID                       VARCHAR(32),
  BADGE_ID                      VARCHAR(20),
  LAST_NAME                     VARCHAR(35),
  FIRST_NAME                    VARCHAR(35),
  MIDDLE_NAME                   VARCHAR(35),
  ABBREVIATION                  VARCHAR(15),
  POSITION                      VARCHAR(25),
  BIRTHDATE                     DATE,
  TERMINATION_DATE              DATE,
  UPDATE_ALLOWED_FLAG           VARCHAR(1)  DEFAULT 'Y',
  DEFAULT_PRINTER_ID            DECIMAL(10, 0),
  SUSPENDED_FLAG                VARCHAR(1)  DEFAULT 'N',
  SUPERVISOR_STAFF_ID           DECIMAL(10, 0),
  COMM_RECEIPT_PRINTER_ID       VARCHAR(12),
  PERSONNEL_TYPE                VARCHAR(12),
  AS_OF_DATE                    DATE,
  EMERGENCY_CONTACT             VARCHAR(20),
  ROLE                          VARCHAR(12),
  SEX_CODE                      VARCHAR(12),
  STATUS                        VARCHAR(12),
  SUSPENSION_DATE               DATE,
  SUSPENSION_REASON             VARCHAR(12),
  FORCE_PASSWORD_CHANGE_FLAG    VARCHAR(1)  DEFAULT 'N',
  LAST_PASSWORD_CHANGE_DATE     DATE,
  LICENSE_CODE                  VARCHAR(12),
  LICENSE_EXPIRY_DATE           DATE,
  CREATE_DATETIME               TIMESTAMP(6)      DEFAULT now(),
  CREATE_USER_ID                VARCHAR(32) DEFAULT USER,
  MODIFY_DATETIME               TIMESTAMP(6),
  MODIFY_USER_ID                VARCHAR(32),
  TITLE                         VARCHAR(12),
  NAME_SEQUENCE                 VARCHAR(12),
  QUEUE_CLUSTER_ID              DECIMAL(6, 0),
  AUDIT_TIMESTAMP               TIMESTAMP(6),
  AUDIT_USER_ID                 VARCHAR(32),
  AUDIT_MODULE_NAME             VARCHAR(65),
  AUDIT_CLIENT_USER_ID          VARCHAR(64),
  AUDIT_CLIENT_IP_ADDRESS       VARCHAR(39),
  AUDIT_CLIENT_WORKSTATION_NAME VARCHAR(64),
  AUDIT_ADDITIONAL_INFO         VARCHAR(256),
  FIRST_LOGON_FLAG              VARCHAR(1)  DEFAULT 'N',
  SIGNIFICANT_DATE              DATE,
  SIGNIFICANT_NAME              VARCHAR(100),
  NATIONAL_INSURANCE_NUMBER     VARCHAR(13)
);

CREATE UNIQUE INDEX STAFF_MEMBERS_PK2 ON STAFF_MEMBERS (USER_ID);

ALTER TABLE STAFF_MEMBERS ALTER STAFF_ID SET NOT NULL;
ALTER TABLE STAFF_MEMBERS ALTER LAST_NAME SET NOT NULL;
ALTER TABLE STAFF_MEMBERS ALTER FIRST_NAME SET NOT NULL;
ALTER TABLE STAFF_MEMBERS ALTER UPDATE_ALLOWED_FLAG SET NOT NULL;
ALTER TABLE STAFF_MEMBERS ALTER CREATE_DATETIME SET NOT NULL;
ALTER TABLE STAFF_MEMBERS ALTER CREATE_USER_ID SET NOT NULL;
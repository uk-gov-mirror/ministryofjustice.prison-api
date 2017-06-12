CREATE SEQUENCE STAFF_ID START WITH 1 NOCYCLE;
CREATE SEQUENCE INTERNET_ADDRESS_ID START WITH 1 NOCYCLE;
CREATE SEQUENCE ROLE_ID START WITH 1 NOCYCLE;

CREATE TABLE STAFF_MEMBERS
(
  "STAFF_ID"                      NUMBER(6, 0),
  "ASSIGNED_CASELOAD_ID"          VARCHAR2(6 CHAR),
  "WORKING_STOCK_LOC_ID"          VARCHAR2(6 CHAR),
  "WORKING_CASELOAD_ID"           VARCHAR2(6 CHAR),
  "USER_ID"                       VARCHAR2(32 CHAR),
  "BADGE_ID"                      VARCHAR2(20 CHAR),
  "LAST_NAME"                     VARCHAR2(35 CHAR),
  "FIRST_NAME"                    VARCHAR2(35 CHAR),
  "MIDDLE_NAME"                   VARCHAR2(35 CHAR),
  "ABBREVIATION"                  VARCHAR2(15 CHAR),
  "POSITION"                      VARCHAR2(25 CHAR),
  "BIRTHDATE"                     DATE,
  "TERMINATION_DATE"              DATE,
  "UPDATE_ALLOWED_FLAG"           VARCHAR2(1 CHAR)  DEFAULT 'Y',
  "DEFAULT_PRINTER_ID"            NUMBER(10, 0),
  "SUSPENDED_FLAG"                VARCHAR2(1 CHAR)  DEFAULT 'N',
  "SUPERVISOR_STAFF_ID"           NUMBER(6, 0),
  "COMM_RECEIPT_PRINTER_ID"       VARCHAR2(12 CHAR),
  "PERSONNEL_TYPE"                VARCHAR2(12 CHAR),
  "AS_OF_DATE"                    DATE,
  "EMERGENCY_CONTACT"             VARCHAR2(20 CHAR),
  "ROLE"                          VARCHAR2(12 CHAR),
  "SEX_CODE"                      VARCHAR2(12 CHAR),
  "STATUS"                        VARCHAR2(12 CHAR),
  "SUSPENSION_DATE"               DATE,
  "SUSPENSION_REASON"             VARCHAR2(12 CHAR),
  "FORCE_PASSWORD_CHANGE_FLAG"    VARCHAR2(1 CHAR)  DEFAULT 'N',
  "LAST_PASSWORD_CHANGE_DATE"     DATE,
  "LICENSE_CODE"                  VARCHAR2(12 CHAR),
  "LICENSE_EXPIRY_DATE"           DATE,
  "CREATE_DATETIME"               TIMESTAMP(9)      DEFAULT systimestamp,
  "CREATE_USER_ID"                VARCHAR2(32 CHAR) DEFAULT USER,
  "MODIFY_DATETIME"               TIMESTAMP(9),
  "MODIFY_USER_ID"                VARCHAR2(32 CHAR),
  "TITLE"                         VARCHAR2(12 CHAR),
  "NAME_SEQUENCE"                 VARCHAR2(12 CHAR),
  "QUEUE_CLUSTER_ID"              NUMBER(6, 0),
  "FIRST_LOGON_FLAG"              VARCHAR2(1 CHAR)  DEFAULT 'Y',
  "SUFFIX"                        VARCHAR2(12 CHAR),
  "SEAL_FLAG"                     VARCHAR2(1 CHAR)
);

CREATE UNIQUE INDEX "STAFF_MEMBERS_PK2" ON "STAFF_MEMBERS" ("USER_ID");

ALTER TABLE "STAFF_MEMBERS" ALTER "STAFF_ID" SET NOT NULL;
ALTER TABLE "STAFF_MEMBERS" ALTER "LAST_NAME" SET NOT NULL;
ALTER TABLE "STAFF_MEMBERS" ALTER "FIRST_NAME" SET NOT NULL;
ALTER TABLE "STAFF_MEMBERS" ALTER "UPDATE_ALLOWED_FLAG" SET NOT NULL;
ALTER TABLE "STAFF_MEMBERS" ALTER "CREATE_DATETIME" SET NOT NULL;
ALTER TABLE "STAFF_MEMBERS" ALTER "CREATE_USER_ID" SET NOT NULL;


CREATE TABLE STAFF_USER_ACCOUNTS
(
  "USERNAME"                      VARCHAR2(30 CHAR),
  "STAFF_ID"                      NUMBER(6, 0),
  "STAFF_USER_TYPE"               VARCHAR2(12 CHAR),
  "ID_SOURCE"                     VARCHAR2(12 CHAR),
  "WORKING_CASELOAD_ID"           VARCHAR2(6 CHAR),
  "CREATE_DATETIME"               TIMESTAMP(9)      DEFAULT systimestamp,
  "CREATE_USER_ID"                VARCHAR2(32 CHAR) DEFAULT USER,
  "MODIFY_DATETIME"               TIMESTAMP(9),
  "MODIFY_USER_ID"                VARCHAR2(32 CHAR),
  "SEAL_FLAG"                     VARCHAR2(1 CHAR)
);

ALTER TABLE "STAFF_USER_ACCOUNTS" ALTER "USERNAME" SET NOT NULL;
ALTER TABLE "STAFF_USER_ACCOUNTS" ALTER "STAFF_ID" SET NOT NULL;
ALTER TABLE "STAFF_USER_ACCOUNTS" ALTER "STAFF_USER_TYPE" SET NOT NULL;
ALTER TABLE "STAFF_USER_ACCOUNTS" ALTER "ID_SOURCE" SET NOT NULL;
ALTER TABLE "STAFF_USER_ACCOUNTS" ALTER "CREATE_DATETIME" SET NOT NULL;
ALTER TABLE "STAFF_USER_ACCOUNTS" ALTER "CREATE_USER_ID" SET NOT NULL;


CREATE TABLE STAFF_MEMBER_ROLES
(
  "STAFF_ID"                      NUMBER(6, 0),
  "ROLE_ID"                       NUMBER(10, 0),
  "CREATE_DATETIME"               TIMESTAMP(9)      DEFAULT systimestamp,
  "CREATE_USER_ID"                VARCHAR2(32 CHAR) DEFAULT USER,
  "MODIFY_DATETIME"               TIMESTAMP(9),
  "MODIFY_USER_ID"                VARCHAR2(32 CHAR),
  "ROLE_CODE"                     VARCHAR2(30 CHAR),
  "SEAL_FLAG"                     VARCHAR2(1 CHAR)
);

ALTER TABLE "STAFF_MEMBER_ROLES" ALTER "STAFF_ID" SET NOT NULL;
ALTER TABLE "STAFF_MEMBER_ROLES" ALTER "ROLE_ID" SET NOT NULL;
ALTER TABLE "STAFF_MEMBER_ROLES" ALTER "CREATE_DATETIME" SET NOT NULL;
ALTER TABLE "STAFF_MEMBER_ROLES" ALTER "CREATE_USER_ID" SET NOT NULL;
ALTER TABLE "STAFF_MEMBER_ROLES" ALTER "ROLE_CODE" SET NOT NULL;


CREATE TABLE INTERNET_ADDRESSES
(
  "INTERNET_ADDRESS_ID"           NUMBER(10, 0),
  "OWNER_CLASS"                   VARCHAR2(12 CHAR),
  "OWNER_ID"                      NUMBER(10, 0),
  "OWNER_SEQ"                     NUMBER(6, 0),
  "OWNER_CODE"                    VARCHAR2(12 CHAR),
  "INTERNET_ADDRESS_CLASS"        VARCHAR2(12 CHAR) DEFAULT 'EMAIL',
  "INTERNET_ADDRESS"              VARCHAR2(240 CHAR),
  "CREATE_DATETIME"               TIMESTAMP(9)      DEFAULT systimestamp,
  "CREATE_USER_ID"                VARCHAR2(32 CHAR) DEFAULT USER,
  "MODIFY_DATETIME"               TIMESTAMP(9),
  "MODIFY_USER_ID"                VARCHAR2(32 CHAR),
  "SEAL_FLAG"                     VARCHAR2(1 CHAR)
);

ALTER TABLE "INTERNET_ADDRESSES" ALTER "INTERNET_ADDRESS_ID" SET NOT NULL;
ALTER TABLE "INTERNET_ADDRESSES" ALTER "OWNER_CLASS" SET NOT NULL;
ALTER TABLE "INTERNET_ADDRESSES" ALTER "INTERNET_ADDRESS_CLASS" SET NOT NULL;
ALTER TABLE "INTERNET_ADDRESSES" ALTER "INTERNET_ADDRESS" SET NOT NULL;
ALTER TABLE "INTERNET_ADDRESSES" ALTER "CREATE_DATETIME" SET NOT NULL;
ALTER TABLE "INTERNET_ADDRESSES" ALTER "CREATE_USER_ID" SET NOT NULL;


CREATE TABLE USER_CASELOAD_ROLES
(
  "ROLE_ID"                       NUMBER(6, 0),
  "USERNAME"                      VARCHAR2(30 CHAR),
  "CASELOAD_ID"                   VARCHAR2(6 CHAR),
  "CREATE_DATETIME"               TIMESTAMP(9)      DEFAULT systimestamp,
  "CREATE_USER_ID"                VARCHAR2(32 CHAR) DEFAULT USER,
  "MODIFY_DATETIME"               TIMESTAMP(9),
  "MODIFY_USER_ID"                VARCHAR2(32 CHAR),
  "SEAL_FLAG"                     VARCHAR2(1 CHAR)
);

ALTER TABLE "USER_CASELOAD_ROLES" ALTER "ROLE_ID" SET NOT NULL;
ALTER TABLE "USER_CASELOAD_ROLES" ALTER "USERNAME" SET NOT NULL;
ALTER TABLE "USER_CASELOAD_ROLES" ALTER "CASELOAD_ID" SET NOT NULL;
ALTER TABLE "USER_CASELOAD_ROLES" ALTER "CREATE_DATETIME" SET NOT NULL;
ALTER TABLE "USER_CASELOAD_ROLES" ALTER "CREATE_USER_ID" SET NOT NULL;


CREATE TABLE OMS_ROLES
(
  "ROLE_ID"                       NUMBER(10, 0),
  "ROLE_NAME"                     VARCHAR2(30 CHAR),
  "ROLE_SEQ"                      NUMBER(3, 0),
  "CREATE_DATETIME"               TIMESTAMP(9)      DEFAULT systimestamp,
  "CREATE_USER_ID"                VARCHAR2(32 CHAR) DEFAULT USER,
  "MODIFY_DATETIME"               TIMESTAMP(9),
  "MODIFY_USER_ID"                VARCHAR2(32 CHAR),
  "ROLE_CODE"                     VARCHAR2(30 CHAR),
  "PARENT_ROLE_CODE"              VARCHAR2(30 CHAR),
  "SEAL_FLAG"                     VARCHAR2(1 CHAR)
);

CREATE UNIQUE INDEX "USER_GROUPS_PK" ON "OMS_ROLES" ("ROLE_ID");
CREATE UNIQUE INDEX "OMS_ROLES_UK" ON "OMS_ROLES" ("ROLE_CODE");

ALTER TABLE "OMS_ROLES" ALTER "ROLE_ID" SET NOT NULL;
ALTER TABLE "OMS_ROLES" ALTER "ROLE_NAME" SET NOT NULL;
ALTER TABLE "OMS_ROLES" ALTER "CREATE_DATETIME" SET NOT NULL;
ALTER TABLE "OMS_ROLES" ALTER "CREATE_USER_ID" SET NOT NULL;
ALTER TABLE "OMS_ROLES" ALTER "ROLE_CODE" SET NOT NULL;


CREATE TABLE SYSTEM_PROFILES
(
  "PROFILE_TYPE"                  VARCHAR2(12 CHAR),
  "PROFILE_CODE"                  VARCHAR2(12 CHAR),
  "DESCRIPTION"                   VARCHAR2(80 CHAR),
  "PROFILE_VALUE"                 VARCHAR2(40 CHAR),
  "PROFILE_VALUE_2"               VARCHAR2(12 CHAR),
  "MODIFY_USER_ID"                VARCHAR2(32 CHAR),
  "OLD_TABLE_NAME"                VARCHAR2(50 CHAR),
  "CREATE_DATETIME"               TIMESTAMP(9)      DEFAULT systimestamp,
  "CREATE_USER_ID"                VARCHAR2(32 CHAR) DEFAULT USER,
  "MODIFY_DATETIME"               TIMESTAMP(9),
  "SEAL_FLAG"                     VARCHAR2(1 CHAR)
);

ALTER TABLE "SYSTEM_PROFILES" ALTER "PROFILE_TYPE" SET NOT NULL;
ALTER TABLE "SYSTEM_PROFILES" ALTER "PROFILE_CODE" SET NOT NULL;
ALTER TABLE "SYSTEM_PROFILES" ALTER "CREATE_DATETIME" SET NOT NULL;
ALTER TABLE "SYSTEM_PROFILES" ALTER "CREATE_USER_ID" SET NOT NULL;
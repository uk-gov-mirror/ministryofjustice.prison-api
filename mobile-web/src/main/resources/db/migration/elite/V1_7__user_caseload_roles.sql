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

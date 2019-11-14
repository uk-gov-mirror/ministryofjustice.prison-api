
  CREATE TABLE "OFFENDER_PROFILES"
   (    "OFFENDER_BOOK_ID" NUMBER(10,0) NOT NULL,
    "PROFILE_SEQ" NUMBER(6,0) NOT NULL,
    "CHECK_DATE" DATE NOT NULL,
    "MODIFY_USER_ID" VARCHAR2(32 CHAR),
    "CREATE_DATETIME" TIMESTAMP (9) DEFAULT systimestamp NOT NULL,
    "CREATE_USER_ID" VARCHAR2(32 CHAR) DEFAULT USER NOT NULL,
    "MODIFY_DATETIME" TIMESTAMP (9),
    "AUDIT_TIMESTAMP" TIMESTAMP (9),
    "AUDIT_USER_ID" VARCHAR2(32 CHAR),
    "AUDIT_MODULE_NAME" VARCHAR2(65 CHAR),
    "AUDIT_CLIENT_USER_ID" VARCHAR2(64 CHAR),
    "AUDIT_CLIENT_IP_ADDRESS" VARCHAR2(39 CHAR),
    "AUDIT_CLIENT_WORKSTATION_NAME" VARCHAR2(64 CHAR),
    "AUDIT_ADDITIONAL_INFO" VARCHAR2(256 CHAR),
     CONSTRAINT "OFFENDER_PROFILES_PK" PRIMARY KEY ("OFFENDER_BOOK_ID", "PROFILE_SEQ"),
  );

  CREATE UNIQUE INDEX "OFFENDER_PROFILES_PK" ON "OFFENDER_PROFILES" ("OFFENDER_BOOK_ID", "PROFILE_SEQ");
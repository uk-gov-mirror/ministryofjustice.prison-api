CREATE TABLE "COURSE_ACTIVITIES"
(
  "CRS_ACTY_ID"                   NUMBER(10, 0)                      NOT NULL ,
  "CASELOAD_ID"                   VARCHAR2(6 CHAR),
  "AGY_LOC_ID"                    VARCHAR2(6 CHAR),
  "DESCRIPTION"                   VARCHAR2(40 CHAR),
  "CAPACITY"                      NUMBER(3, 0)     DEFAULT 99,
  "ACTIVE_FLAG"                   VARCHAR2(1 CHAR) DEFAULT 'Y'       NOT NULL ,
  "EXPIRY_DATE"                   DATE,
  "SCHEDULE_START_DATE"           DATE,
  "SCHEDULE_END_DATE"             DATE,
  "CASELOAD_TYPE"                 VARCHAR2(12 CHAR),
  "SERVICES_ADDRESS_ID"           NUMBER(10, 0),
  "PROGRAM_ID"                    NUMBER(10, 0)                      NOT NULL ,
  "PARENT_CRS_ACTY_ID"            NUMBER(10, 0),
  "INTERNAL_LOCATION_ID"          NUMBER(10, 0),
  "PROVIDER_PARTY_CLASS"          VARCHAR2(12 CHAR),
  "PROVIDER_PARTY_ID"             NUMBER(10, 0),
  "PROVIDER_PARTY_CODE"           VARCHAR2(6 CHAR),
  "BENEFICIARY_NAME"              VARCHAR2(80 CHAR),
  "BENEFICIARY_CONTACT"           VARCHAR2(80 CHAR),
  "LIST_SEQ"                      NUMBER(6, 0),
  "PLACEMENT_CORPORATE_ID"        NUMBER(10, 0),
  "COMMENT_TEXT"                  VARCHAR2(240 CHAR),
  "AGENCY_LOCATION_TYPE"          VARCHAR2(12 CHAR),
  "PROVIDER_TYPE"                 VARCHAR2(12 CHAR),
  "BENEFICIARY_TYPE"              VARCHAR2(12 CHAR),
  "PLACEMENT_TEXT"                VARCHAR2(240 CHAR),
  "CODE"                          VARCHAR2(20 CHAR),
  "HOLIDAY_FLAG"                  VARCHAR2(1 CHAR) DEFAULT 'N',
  "COURSE_CLASS"                  VARCHAR2(12 CHAR) DEFAULT 'COURSE' NOT NULL ,
  "COURSE_ACTIVITY_TYPE"          VARCHAR2(12 CHAR),
  "CREATE_DATETIME"               TIMESTAMP(9) DEFAULT systimestamp  NOT NULL ,
  "CREATE_USER_ID"                VARCHAR2(32 CHAR) DEFAULT USER     NOT NULL ,
  "MODIFY_DATETIME"               TIMESTAMP(9),
  "MODIFY_USER_ID"                VARCHAR2(32 CHAR),
  "IEP_LEVEL"                     VARCHAR2(12 CHAR),
  "AUDIT_TIMESTAMP"               TIMESTAMP(9),
  "AUDIT_USER_ID"                 VARCHAR2(32 CHAR),
  "AUDIT_MODULE_NAME"             VARCHAR2(65 CHAR),
  "AUDIT_CLIENT_USER_ID"          VARCHAR2(64 CHAR),
  "AUDIT_CLIENT_IP_ADDRESS"       VARCHAR2(39 CHAR),
  "AUDIT_CLIENT_WORKSTATION_NAME" VARCHAR2(64 CHAR),
  "AUDIT_ADDITIONAL_INFO"         VARCHAR2(256 CHAR),
  "NO_OF_SESSIONS"                NUMBER(6, 0),
  "SESSION_LENGTH"                NUMBER(6, 0),
  "MULTI_PHASE_SCHEDULING_FLAG"   VARCHAR2(12 CHAR),
  "SCHEDULE_NOTES"                VARCHAR2(240 CHAR),
  "OUTSIDE_WORK_FLAG"             VARCHAR2(1 CHAR) DEFAULT 'N',
  "PAY_PER_SESSION"               VARCHAR2(1 CHAR) DEFAULT 'H',
  "PIECE_WORK_FLAG"               VARCHAR2(1 CHAR) DEFAULT 'N',
  CONSTRAINT "COURSE_ACTIVITIES_CHK1" CHECK (course_class IN ('COURSE', 'CRS_MOD', 'CRS_PH') ) ,
  CONSTRAINT "COURSE_ACTIVITIES_PK" PRIMARY KEY ("CRS_ACTY_ID"),
  CONSTRAINT "CSR_ACTY_PRG_SERV_FK" FOREIGN KEY ("PROGRAM_ID")
  REFERENCES "PROGRAM_SERVICES" ("PROGRAM_ID")   ,
  CONSTRAINT "CRS_ACT_CRS_ACT_FK" FOREIGN KEY ("PARENT_CRS_ACTY_ID")
  REFERENCES "COURSE_ACTIVITIES" ("CRS_ACTY_ID") ,
  CONSTRAINT "CRS_ACTY_AGY_LOC_FK" FOREIGN KEY ("AGY_LOC_ID")
  REFERENCES "AGENCY_LOCATIONS" ("AGY_LOC_ID") ,
  CONSTRAINT "CRS_ACTY_ADDR_FK" FOREIGN KEY ("SERVICES_ADDRESS_ID")
  REFERENCES "ADDRESSES" ("ADDRESS_ID") ,
  CONSTRAINT "CRS_ACTY_CORP_FK" FOREIGN KEY ("PLACEMENT_CORPORATE_ID")
  REFERENCES "CORPORATES" ("CORPORATE_ID")
);


COMMENT ON COLUMN "COURSE_ACTIVITIES"."CRS_ACTY_ID" IS 'Course Aactivity ID';

COMMENT ON COLUMN "COURSE_ACTIVITIES"."CASELOAD_ID" IS 'Caseload ID';

COMMENT ON COLUMN "COURSE_ACTIVITIES"."AGY_LOC_ID" IS 'The location residing within an agency - link to caseload agency locations - Retrofitted';

COMMENT ON COLUMN "COURSE_ACTIVITIES"."DESCRIPTION" IS 'Description of the Course/Activity - Retrofitted';

COMMENT ON COLUMN "COURSE_ACTIVITIES"."CAPACITY" IS 'Number of spaces on the course/activity - Retrofitted';

COMMENT ON COLUMN "COURSE_ACTIVITIES"."ACTIVE_FLAG" IS 'Y/N field to say if the course is active - Retrofitted';

COMMENT ON COLUMN "COURSE_ACTIVITIES"."EXPIRY_DATE" IS 'Date the Course/Activity Date became inactive - Retrofitted';

COMMENT ON COLUMN "COURSE_ACTIVITIES"."SCHEDULE_START_DATE" IS 'Start Date';

COMMENT ON COLUMN "COURSE_ACTIVITIES"."SCHEDULE_END_DATE" IS 'End Date';

COMMENT ON COLUMN "COURSE_ACTIVITIES"."CASELOAD_TYPE" IS 'Reference Code [ CSLD_TYPE ] : Type of Caseload - ie Institution, Office etc.';

COMMENT ON COLUMN "COURSE_ACTIVITIES"."SERVICES_ADDRESS_ID" IS 'The address where the services(course/activity) takes place';

COMMENT ON COLUMN "COURSE_ACTIVITIES"."PROGRAM_ID" IS 'The Program ID';

COMMENT ON COLUMN "COURSE_ACTIVITIES"."PARENT_CRS_ACTY_ID" IS 'The parent of course activity ID';

COMMENT ON COLUMN "COURSE_ACTIVITIES"."INTERNAL_LOCATION_ID" IS 'The internal location of agency location';

COMMENT ON COLUMN "COURSE_ACTIVITIES"."PROVIDER_PARTY_CLASS" IS 'The party class of the provider';

COMMENT ON COLUMN "COURSE_ACTIVITIES"."PROVIDER_PARTY_ID" IS 'The party id of the provider';

COMMENT ON COLUMN "COURSE_ACTIVITIES"."PROVIDER_PARTY_CODE" IS 'The party code of the provider';

COMMENT ON COLUMN "COURSE_ACTIVITIES"."BENEFICIARY_NAME" IS 'The name of the beneficiary';

COMMENT ON COLUMN "COURSE_ACTIVITIES"."BENEFICIARY_CONTACT" IS 'The contact details of the beneficiary';

COMMENT ON COLUMN "COURSE_ACTIVITIES"."LIST_SEQ" IS 'The order of the listing';

COMMENT ON COLUMN "COURSE_ACTIVITIES"."PLACEMENT_CORPORATE_ID" IS 'The corporate of the placement';

COMMENT ON COLUMN "COURSE_ACTIVITIES"."COMMENT_TEXT" IS 'The general comment text';

COMMENT ON COLUMN "COURSE_ACTIVITIES"."AGENCY_LOCATION_TYPE" IS 'The agency location type';

COMMENT ON COLUMN "COURSE_ACTIVITIES"."PROVIDER_TYPE" IS 'The Provider Type';

COMMENT ON COLUMN "COURSE_ACTIVITIES"."BENEFICIARY_TYPE" IS 'The beneficiary type.  Reference Code(PS_BENEF)';

COMMENT ON COLUMN "COURSE_ACTIVITIES"."PLACEMENT_TEXT" IS 'The general text of the placement';

COMMENT ON COLUMN "COURSE_ACTIVITIES"."CODE" IS 'The Course acitivity short code';

COMMENT ON COLUMN "COURSE_ACTIVITIES"."HOLIDAY_FLAG" IS 'If the course/activity conform to national holidays';

COMMENT ON COLUMN "COURSE_ACTIVITIES"."COURSE_CLASS" IS 'The class of the course/activity';

COMMENT ON COLUMN "COURSE_ACTIVITIES"."COURSE_ACTIVITY_TYPE" IS 'The course activity type.  Reference Code(PS_CRS_TYPE)';

COMMENT ON COLUMN "COURSE_ACTIVITIES"."CREATE_DATETIME" IS 'The timestamp when the record is created';

COMMENT ON COLUMN "COURSE_ACTIVITIES"."CREATE_USER_ID" IS 'The user who creates the record';

COMMENT ON COLUMN "COURSE_ACTIVITIES"."MODIFY_DATETIME" IS 'The timestamp when the record is modified ';

COMMENT ON COLUMN "COURSE_ACTIVITIES"."MODIFY_USER_ID" IS 'The user who modifies the record';

COMMENT ON COLUMN "COURSE_ACTIVITIES"."NO_OF_SESSIONS" IS 'Number of total sessions';

COMMENT ON COLUMN "COURSE_ACTIVITIES"."SESSION_LENGTH" IS 'The duration of each session';

COMMENT ON COLUMN "COURSE_ACTIVITIES"."MULTI_PHASE_SCHEDULING_FLAG" IS '?Multi-Phase scheduling';

COMMENT ON COLUMN "COURSE_ACTIVITIES"."SCHEDULE_NOTES" IS 'The Note of the course schedule';

COMMENT ON TABLE "COURSE_ACTIVITIES" IS 'The scheduled delivery of a program service (eg an accredited programme, a prison activity or an unpaid work project) by a particular provider.';


CREATE INDEX "COURSE_ACTIVITIES_NI1"
  ON "COURSE_ACTIVITIES" ("COURSE_CLASS");


CREATE INDEX "COURSE_ACTIVITIES_NI2"
  ON "COURSE_ACTIVITIES" ("PARENT_CRS_ACTY_ID");


CREATE INDEX "COURSE_ACTIVITIES_NI3"
  ON "COURSE_ACTIVITIES" ("SCHEDULE_START_DATE");


CREATE INDEX "COURSE_ACTIVITIES_NI4"
  ON "COURSE_ACTIVITIES" ("SCHEDULE_END_DATE");


CREATE INDEX "COURSE_ACTIVITIES_NI5"
  ON "COURSE_ACTIVITIES" ("PROVIDER_PARTY_ID");


CREATE INDEX "COURSE_ACTIVITIES_NI6"
  ON "COURSE_ACTIVITIES" ("PROVIDER_PARTY_CODE");


CREATE INDEX "COURSE_ACTIVITIES_NI7"
  ON "COURSE_ACTIVITIES" ("PLACEMENT_CORPORATE_ID");


CREATE INDEX "COURSE_ACTIVITIES_NI8"
  ON "COURSE_ACTIVITIES" ("PROGRAM_ID");


CREATE INDEX "COURSE_ACTIVITIES_NI9"
  ON "COURSE_ACTIVITIES" ("AGY_LOC_ID");


CREATE INDEX "CRS_ACTY_ADDR_FK"
  ON "COURSE_ACTIVITIES" ("SERVICES_ADDRESS_ID");


CREATE INDEX "CRS_ACT_AGY_INT_LOC_FK"
  ON "COURSE_ACTIVITIES" ("INTERNAL_LOCATION_ID");


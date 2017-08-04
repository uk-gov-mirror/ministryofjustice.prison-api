CREATE TABLE AGENCY_INTERNAL_LOCATIONS
(
  "INTERNAL_LOCATION_ID"          NUMBER(10, 0),
  "INTERNAL_LOCATION_CODE"        VARCHAR2(40 CHAR),
  "AGY_LOC_ID"                    VARCHAR2(6 CHAR),
  "INTERNAL_LOCATION_TYPE"        VARCHAR2(12 CHAR),
  "DESCRIPTION"                   VARCHAR2(240 CHAR),
  "SECURITY_LEVEL_CODE"           VARCHAR2(12 CHAR),
  "CAPACITY"                      NUMBER(5, 0),
  "CREATE_USER_ID"                VARCHAR2(32 CHAR) DEFAULT USER,
  "PARENT_INTERNAL_LOCATION_ID"   NUMBER(10, 0),
  "ACTIVE_FLAG"                   VARCHAR2(1 CHAR)  DEFAULT 'Y',
  "LIST_SEQ"                      NUMBER(6, 0),
  "CREATE_DATETIME"               TIMESTAMP(9)      DEFAULT systimestamp,
  "MODIFY_DATETIME"               TIMESTAMP(9),
  "MODIFY_USER_ID"                VARCHAR2(32 CHAR),
  "CNA_NO"                        NUMBER(10, 0),
  "CERTIFIED_FLAG"                VARCHAR2(1 CHAR)  DEFAULT 'N',
  "DEACTIVATE_DATE"               DATE,
  "REACTIVATE_DATE"               DATE,
  "DEACTIVATE_REASON_CODE"        VARCHAR2(12 CHAR),
  "COMMENT_TEXT"                  VARCHAR2(240 CHAR),
  "USER_DESC"                     VARCHAR2(40 CHAR),
  "ACA_CAP_RATING"                NUMBER(5, 0),
  "UNIT_TYPE"                     VARCHAR2(12 CHAR),
  "OPERATION_CAPACITY"            NUMBER(5, 0),
  "NO_OF_OCCUPANT"                NUMBER(10, 0)     DEFAULT 0,
  "TRACKING_FLAG"                 VARCHAR2(1 CHAR)  DEFAULT 'N',
  "SEAL_FLAG"                     VARCHAR2(1 CHAR)
);

CREATE UNIQUE INDEX "AGENCY_INTERNAL_LOCATIONS_UK" ON "AGENCY_INTERNAL_LOCATIONS" ("AGY_LOC_ID", "DESCRIPTION");
CREATE UNIQUE INDEX "INTERNAL_LOCATIONS_PK" ON "AGENCY_INTERNAL_LOCATIONS" ("INTERNAL_LOCATION_ID");

ALTER TABLE "AGENCY_INTERNAL_LOCATIONS" ALTER "INTERNAL_LOCATION_ID" SET NOT NULL;
ALTER TABLE "AGENCY_INTERNAL_LOCATIONS" ALTER "INTERNAL_LOCATION_CODE" SET NOT NULL;
ALTER TABLE "AGENCY_INTERNAL_LOCATIONS" ALTER "AGY_LOC_ID" SET NOT NULL;
ALTER TABLE "AGENCY_INTERNAL_LOCATIONS" ALTER "INTERNAL_LOCATION_TYPE" SET NOT NULL;
ALTER TABLE "AGENCY_INTERNAL_LOCATIONS" ALTER "DESCRIPTION" SET NOT NULL;
ALTER TABLE "AGENCY_INTERNAL_LOCATIONS" ALTER "ACTIVE_FLAG" SET NOT NULL;
ALTER TABLE "AGENCY_INTERNAL_LOCATIONS" ALTER "CERTIFIED_FLAG" SET NOT NULL;
ALTER TABLE "AGENCY_INTERNAL_LOCATIONS" ALTER "TRACKING_FLAG" SET NOT NULL;
ALTER TABLE "AGENCY_INTERNAL_LOCATIONS" ALTER "CREATE_DATETIME" SET NOT NULL;
ALTER TABLE "AGENCY_INTERNAL_LOCATIONS" ALTER "CREATE_USER_ID" SET NOT NULL;


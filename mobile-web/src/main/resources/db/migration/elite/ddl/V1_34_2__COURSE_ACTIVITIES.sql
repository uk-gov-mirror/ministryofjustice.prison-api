CREATE TABLE COURSE_ACTIVITIES
(
  CRS_ACTY_ID                     NUMBER(10)                          NOT NULL,
  CASELOAD_ID                     VARCHAR2(6),
  AGY_LOC_ID                      VARCHAR2(6),
  DESCRIPTION                     VARCHAR2(40),
  CAPACITY                        NUMBER(3)      DEFAULT 99,
  ACTIVE_FLAG                     VARCHAR2(1)    DEFAULT 'Y'          NOT NULL,
  EXPIRY_DATE                     DATE,
  SCHEDULE_START_DATE             DATE,
  SCHEDULE_END_DATE               DATE,
  CASELOAD_TYPE                   VARCHAR2(12),
  SERVICES_ADDRESS_ID             NUMBER(10),
  PROGRAM_ID                      NUMBER(10)                          NOT NULL,
  PARENT_CRS_ACTY_ID              NUMBER(10),
  INTERNAL_LOCATION_ID            NUMBER(10),
  PROVIDER_PARTY_CLASS            VARCHAR2(12),
  PROVIDER_PARTY_ID               NUMBER(10),
  PROVIDER_PARTY_CODE             VARCHAR2(6),
  BENEFICIARY_NAME                VARCHAR2(80),
  BENEFICIARY_CONTACT             VARCHAR2(80),
  LIST_SEQ                        NUMBER(6),
  PLACEMENT_CORPORATE_ID          NUMBER(10),
  COMMENT_TEXT                    VARCHAR2(240),
  AGENCY_LOCATION_TYPE            VARCHAR2(12),
  PROVIDER_TYPE                   VARCHAR2(12),
  BENEFICIARY_TYPE                VARCHAR2(12),
  PLACEMENT_TEXT                  VARCHAR2(240),
  CODE                            VARCHAR2(20),
  HOLIDAY_FLAG                    VARCHAR2(1)    DEFAULT 'N',
  COURSE_CLASS                    VARCHAR2(12)   DEFAULT 'COURSE'     NOT NULL,
  COURSE_ACTIVITY_TYPE            VARCHAR2(12),
  CREATE_DATETIME                 TIMESTAMP(9)   DEFAULT SYSTIMESTAMP NOT NULL,
  CREATE_USER_ID                  VARCHAR2(32)   DEFAULT USER         NOT NULL,
  MODIFY_DATETIME                 TIMESTAMP(9)   DEFAULT SYSTIMESTAMP,
  MODIFY_USER_ID                  VARCHAR2(32),
  IEP_LEVEL                       VARCHAR2(12),
  NO_OF_SESSIONS                  NUMBER(6),
  SESSION_LENGTH                  NUMBER(6),
  MULTI_PHASE_SCHEDULING_FLAG     VARCHAR2(12),
  SCHEDULE_NOTES                  VARCHAR2(240),
  SEAL_FLAG                       VARCHAR2(1),
  ALLOW_DOUBLE_BOOK_FLAG          VARCHAR2(1)
);

ALTER TABLE COURSE_ACTIVITIES ADD CONSTRAINT COURSE_ACTIVITIES_PK PRIMARY KEY (CRS_ACTY_ID);

--ALTER TABLE COURSE_ACTIVITIES ADD FOREIGN KEY (AGY_LOC_ID) REFERENCES AGENCY_LOCATIONS;
--ALTER TABLE COURSE_ACTIVITIES ADD FOREIGN KEY (INTERNAL_LOCATION_ID) REFERENCES AGENCY_INTERNAL_LOCATIONS;
--ALTER TABLE COURSE_ACTIVITIES ADD FOREIGN KEY (SERVICES_ADDRESS_ID) REFERENCES ADDRESSES;
--ALTER TABLE COURSE_ACTIVITIES ADD FOREIGN KEY (PROGRAM_ID) REFERENCES PROGRAM_SERVICES;
--ALTER TABLE COURSE_ACTIVITIES ADD FOREIGN KEY (PARENT_CRS_ACTY_ID) REFERENCES COURSE_ACTIVITIES;
ALTER TABLE COURSE_ACTIVITIES ADD FOREIGN KEY (PLACEMENT_CORPORATE_ID) REFERENCES CORPORATES;
ALTER TABLE COURSE_ACTIVITIES ADD CHECK (COURSE_CLASS IN ('COURSE','CRS_MOD','CRS_PH', 'MED_SCHED'));
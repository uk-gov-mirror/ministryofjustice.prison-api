CREATE TABLE AGENCY_LOCATIONS
(
  AGY_LOC_ID                    VARCHAR(6),
  DESCRIPTION                   VARCHAR(40),
  AGENCY_LOCATION_TYPE          VARCHAR(12),
  DISTRICT_CODE                 VARCHAR(12),
  UPDATED_ALLOWED_FLAG          VARCHAR(1)  DEFAULT 'Y',
  ABBREVIATION                  VARCHAR(12),
  DEACTIVATION_DATE             DATE,
  CONTACT_NAME                  VARCHAR(40),
  PRINT_QUEUE                   VARCHAR(240),
  JURISDICTION_CODE             VARCHAR(12),
  BAIL_OFFICE_FLAG              VARCHAR(1)  DEFAULT 'Y',
  LIST_SEQ                      DECIMAL(6, 0),
  HOUSING_LEV_1_CODE            VARCHAR(12),
  HOUSING_LEV_2_CODE            VARCHAR(12),
  HOUSING_LEV_3_CODE            VARCHAR(12),
  HOUSING_LEV_4_CODE            VARCHAR(12),
  PROPERTY_LEV_1_CODE           VARCHAR(12),
  PROPERTY_LEV_2_CODE           VARCHAR(12),
  PROPERTY_LEV_3_CODE           VARCHAR(12),
  LAST_BOOKING_NO               DECIMAL(10, 0),
  COMMISSARY_PRIVILEGE          VARCHAR(12),
  BUSINESS_HOURS                VARCHAR(40),
  ADDRESS_TYPE                  VARCHAR(12),
  SERVICE_REQUIRED_FLAG         VARCHAR(1)  DEFAULT NULL,
  ACTIVE_FLAG                   VARCHAR(1)  DEFAULT NULL,
  DISABILITY_ACCESS_CODE        VARCHAR(12),
  INTAKE_FLAG                   VARCHAR(1)  DEFAULT NULL,
  SUB_AREA_CODE                 VARCHAR(12),
  AREA_CODE                     VARCHAR(12),
  NOMS_REGION_CODE              VARCHAR(12),
  GEOGRAPHIC_REGION_CODE        VARCHAR(12),
  JUSTICE_AREA_CODE             VARCHAR(12),
  CJIT_CODE                     VARCHAR(12),
  LONG_DESCRIPTION              VARCHAR(3000),
  CREATE_DATETIME               TIMESTAMP(6)      DEFAULT now(),
  CREATE_USER_ID                VARCHAR(32) DEFAULT USER,
  MODIFY_DATETIME               TIMESTAMP(6),
  MODIFY_USER_ID                VARCHAR(32),
  AUDIT_TIMESTAMP               TIMESTAMP(6),
  AUDIT_USER_ID                 VARCHAR(32),
  AUDIT_MODULE_NAME             VARCHAR(65),
  AUDIT_CLIENT_USER_ID          VARCHAR(64),
  AUDIT_CLIENT_IP_ADDRESS       VARCHAR(39),
  AUDIT_CLIENT_WORKSTATION_NAME VARCHAR(64),
  AUDIT_ADDITIONAL_INFO         VARCHAR(256)
);

ALTER TABLE AGENCY_LOCATIONS ALTER AGY_LOC_ID SET NOT NULL;
ALTER TABLE AGENCY_LOCATIONS ALTER DESCRIPTION SET NOT NULL;
ALTER TABLE AGENCY_LOCATIONS ALTER UPDATED_ALLOWED_FLAG SET NOT NULL;
ALTER TABLE AGENCY_LOCATIONS ALTER BAIL_OFFICE_FLAG SET NOT NULL;
ALTER TABLE AGENCY_LOCATIONS ALTER CREATE_DATETIME SET NOT NULL;
ALTER TABLE AGENCY_LOCATIONS ALTER CREATE_USER_ID SET NOT NULL;
CREATE TABLE OMS_ROLES
(
  ROLE_ID                       DECIMAL(10, 0),
  ROLE_NAME                     VARCHAR(30),
  ROLE_SEQ                      DECIMAL(3, 0),
  CREATE_DATETIME               TIMESTAMP(6)      DEFAULT now(),
  CREATE_USER_ID                VARCHAR(32) DEFAULT USER,
  MODIFY_DATETIME               TIMESTAMP(6),
  MODIFY_USER_ID                VARCHAR(32),
  ROLE_CODE                     VARCHAR(30),
  PARENT_ROLE_CODE              VARCHAR(30),
  AUDIT_TIMESTAMP               TIMESTAMP(6),
  AUDIT_USER_ID                 VARCHAR(32),
  AUDIT_MODULE_NAME             VARCHAR(65),
  AUDIT_CLIENT_USER_ID          VARCHAR(64),
  AUDIT_CLIENT_IP_ADDRESS       VARCHAR(39),
  AUDIT_CLIENT_WORKSTATION_NAME VARCHAR(64),
  AUDIT_ADDITIONAL_INFO         VARCHAR(256),
  ROLE_TYPE                     VARCHAR(12),
  ROLE_FUNCTION                 VARCHAR(12) DEFAULT 'GENERAL',
  SYSTEM_DATA_FLAG              VARCHAR(1)  DEFAULT 'N'
);

CREATE UNIQUE INDEX USER_GROUPS_PK ON OMS_ROLES (ROLE_ID);
CREATE UNIQUE INDEX OMS_ROLES_UK ON OMS_ROLES (ROLE_CODE);

ALTER TABLE OMS_ROLES ALTER ROLE_ID SET NOT NULL;
ALTER TABLE OMS_ROLES ALTER ROLE_NAME SET NOT NULL;
ALTER TABLE OMS_ROLES ALTER ROLE_SEQ SET NOT NULL;
ALTER TABLE OMS_ROLES ALTER CREATE_DATETIME SET NOT NULL;
ALTER TABLE OMS_ROLES ALTER CREATE_USER_ID SET NOT NULL;
ALTER TABLE OMS_ROLES ALTER ROLE_CODE SET NOT NULL;
ALTER TABLE OMS_ROLES ALTER ROLE_FUNCTION SET NOT NULL;
ALTER TABLE OMS_ROLES ALTER SYSTEM_DATA_FLAG SET NOT NULL;
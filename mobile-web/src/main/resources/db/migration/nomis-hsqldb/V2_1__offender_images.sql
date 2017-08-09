CREATE TABLE OFFENDER_IMAGES
(
  OFFENDER_IMAGE_ID             DECIMAL(10, 0) PRIMARY KEY,
  OFFENDER_BOOK_ID              DECIMAL(10, 0) NOT NULL,
  CAPTURE_DATETIME              DATE NOT NULL,
  ORIENTATION_TYPE              VARCHAR(12) NOT NULL,
  FULL_SIZE_IMAGE               BLOB,
  THUMBNAIL_IMAGE               BLOB,
  IMAGE_OBJECT_TYPE             VARCHAR(12) NOT NULL,
  IMAGE_VIEW_TYPE               VARCHAR(12),
  IMAGE_OBJECT_ID               DECIMAL(10, 0),
  IMAGE_OBJECT_SEQ              DECIMAL(10, 0),
  ACTIVE_FLAG                   VARCHAR(1) DEFAULT 'N' NOT NULL,
  IMAGE_SOURCE_CODE             VARCHAR(12),
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
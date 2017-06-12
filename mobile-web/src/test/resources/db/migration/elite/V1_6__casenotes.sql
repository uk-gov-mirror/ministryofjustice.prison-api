CREATE SEQUENCE CASE_NOTE_ID START WITH 1000 NOCYCLE;

CREATE TABLE OFFENDER_CASE_NOTES
(
  "OFFENDER_BOOK_ID"              NUMBER(10, 0),
  "CONTACT_DATE"                  DATE,
  "CONTACT_TIME"                  DATE,
  "CASE_NOTE_TYPE"                VARCHAR2(12 CHAR),
  "CASE_NOTE_SUB_TYPE"            VARCHAR2(12 CHAR),
  "STAFF_ID"                      NUMBER(10, 0),
  "CASE_NOTE_TEXT"                VARCHAR2(4000 CHAR),
  "AMENDMENT_FLAG"                VARCHAR2(1 CHAR)  DEFAULT 'N',
  "IWP_FLAG"                      VARCHAR2(1 CHAR)  DEFAULT 'N',
  "CHECK_BOX1"                    VARCHAR2(1 CHAR)  DEFAULT 'N',
  "CHECK_BOX2"                    VARCHAR2(1 CHAR)  DEFAULT 'N',
  "CHECK_BOX3"                    VARCHAR2(1 CHAR)  DEFAULT 'N',
  "CHECK_BOX4"                    VARCHAR2(1 CHAR)  DEFAULT 'N',
  "CHECK_BOX5"                    VARCHAR2(1 CHAR)  DEFAULT 'N',
  "EVENT_ID"                      NUMBER(10, 0),
  "CASE_NOTE_ID"                  NUMBER(10, 0),
  "NOTE_SOURCE_CODE"              VARCHAR2(12 CHAR),
  "DATE_CREATION"                 DATE              DEFAULT sysdate,
  "TIME_CREATION"                 DATE,
  "SEAL_FLAG"                     VARCHAR2(1 CHAR),
	"OBJECT_TYPE"                   VARCHAR2(20 CHAR),
	"OBJECT_ID"                     NUMBER(10, 0),
  "CREATE_DATETIME"               TIMESTAMP(9)      DEFAULT systimestamp,
  "CREATE_USER_ID"                VARCHAR2(32 CHAR) DEFAULT USER,
  "MODIFY_DATETIME"               TIMESTAMP(9),
  "MODIFY_USER_ID"                VARCHAR2(32 CHAR)
);

ALTER TABLE "OFFENDER_CASE_NOTES" ALTER "OFFENDER_BOOK_ID" SET NOT NULL;
ALTER TABLE "OFFENDER_CASE_NOTES" ALTER "CONTACT_DATE" SET NOT NULL;
ALTER TABLE "OFFENDER_CASE_NOTES" ALTER "CONTACT_TIME" SET NOT NULL;
ALTER TABLE "OFFENDER_CASE_NOTES" ALTER "CASE_NOTE_TYPE" SET NOT NULL;
ALTER TABLE "OFFENDER_CASE_NOTES" ALTER "CASE_NOTE_SUB_TYPE" SET NOT NULL;
ALTER TABLE "OFFENDER_CASE_NOTES" ALTER "STAFF_ID" SET NOT NULL;
ALTER TABLE "OFFENDER_CASE_NOTES" ALTER "AMENDMENT_FLAG" SET NOT NULL;
ALTER TABLE "OFFENDER_CASE_NOTES" ALTER "IWP_FLAG" SET NOT NULL;
ALTER TABLE "OFFENDER_CASE_NOTES" ALTER "CHECK_BOX1" SET NOT NULL;
ALTER TABLE "OFFENDER_CASE_NOTES" ALTER "CHECK_BOX2" SET NOT NULL;
ALTER TABLE "OFFENDER_CASE_NOTES" ALTER "CHECK_BOX3" SET NOT NULL;
ALTER TABLE "OFFENDER_CASE_NOTES" ALTER "CHECK_BOX4" SET NOT NULL;
ALTER TABLE "OFFENDER_CASE_NOTES" ALTER "CHECK_BOX5" SET NOT NULL;
ALTER TABLE "OFFENDER_CASE_NOTES" ALTER "CASE_NOTE_ID" SET NOT NULL;
ALTER TABLE "OFFENDER_CASE_NOTES" ALTER "CREATE_DATETIME" SET NOT NULL;
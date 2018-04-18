-- OFFENDER_COURSE_ATTENDANCES (record of offenders having attended scheduled activitie)
INSERT INTO OFFENDER_COURSE_ATTENDANCES (EVENT_ID, OFFENDER_BOOK_ID, CRS_SCH_ID, EVENT_CLASS, EVENT_TYPE, EVENT_SUB_TYPE, EVENT_DATE, EVENT_STATUS)
VALUES (-1, -3, -6, 'INT_MOV', 'PRISON_ACT', 'EDUC', TO_DATE(TO_DATE('2017-09-11', 'YYYY-MM-DD'), 'YYYY-MM-DD'), 'EXP');

INSERT INTO OFFENDER_COURSE_ATTENDANCES (EVENT_ID, OFFENDER_BOOK_ID, CRS_SCH_ID, EVENT_CLASS, EVENT_TYPE, EVENT_SUB_TYPE, EVENT_DATE, EVENT_STATUS) VALUES (-2, -3, -7, 'INT_MOV', 'PRISON_ACT', 'EDUC', TO_DATE(TO_DATE('2017-09-12', 'YYYY-MM-DD'), 'YYYY-MM-DD'), 'SCH');

-- OFFENDER_COURSE_ATTENDANCES (record of offenders attendance of scheduled activities)
INSERT INTO OFFENDER_COURSE_ATTENDANCES (EVENT_ID, OFFENDER_BOOK_ID, CRS_SCH_ID, EVENT_CLASS, EVENT_TYPE, EVENT_SUB_TYPE, EVENT_DATE, EVENT_STATUS)
VALUES (-3, -4, -6, 'INT_MOV', 'PRISON_ACT', 'EDUC', TO_DATE('2017-09-11', 'YYYY-MM-DD'), 'COMP');

INSERT INTO OFFENDER_COURSE_ATTENDANCES (EVENT_ID, OFFENDER_BOOK_ID, CRS_SCH_ID, EVENT_CLASS, EVENT_TYPE, EVENT_SUB_TYPE, EVENT_DATE, EVENT_STATUS) VALUES (-4, -3, -7, 'INT_MOV', 'PRISON_ACT', 'EDUC', TO_DATE('2017-09-12', 'YYYY-MM-DD'), 'EXP');
INSERT INTO OFFENDER_COURSE_ATTENDANCES (EVENT_ID, OFFENDER_BOOK_ID, CRS_SCH_ID, EVENT_CLASS, EVENT_TYPE, EVENT_SUB_TYPE, EVENT_DATE, EVENT_STATUS) VALUES (-5, -3, -8, 'INT_MOV', 'PRISON_ACT', 'EDUC', TO_DATE('2017-09-13', 'YYYY-MM-DD'), 'CANC');
INSERT INTO OFFENDER_COURSE_ATTENDANCES (EVENT_ID, OFFENDER_BOOK_ID, CRS_SCH_ID, EVENT_CLASS, EVENT_TYPE, EVENT_SUB_TYPE, EVENT_DATE, EVENT_STATUS) VALUES (-6, -3, -9, 'INT_MOV', 'PRISON_ACT', 'EDUC', TO_DATE('2017-09-14', 'YYYY-MM-DD'), 'SCH');
INSERT INTO OFFENDER_COURSE_ATTENDANCES (EVENT_ID, OFFENDER_BOOK_ID, CRS_SCH_ID, EVENT_CLASS, EVENT_TYPE, EVENT_SUB_TYPE, EVENT_DATE, EVENT_STATUS) VALUES (-7, -3, -10, 'INT_MOV', 'PRISON_ACT', 'EDUC', TO_DATE('2017-09-15', 'YYYY-MM-DD'), 'SCH');
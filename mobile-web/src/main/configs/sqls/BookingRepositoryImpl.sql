GET_BOOKING_SENTENCE_DETAIL {
  SELECT OB.OFFENDER_BOOK_ID,
    (SELECT MIN(OST.START_DATE)
     FROM OFFENDER_SENTENCE_TERMS OST
     WHERE OST.SENTENCE_TERM_CODE = 'IMP'
     AND OST.OFFENDER_BOOK_ID = OB.OFFENDER_BOOK_ID
     GROUP BY OST.OFFENDER_BOOK_ID) AS SENTENCE_START_DATE,
    SED AS SENTENCE_EXPIRY_DATE,
    LED AS LICENCE_EXPIRY_DATE,
    PED AS PAROLE_ELIGIBILITY_DATE,
    HDCED AS HOME_DET_CURF_ELIGIBILITY_DATE,
    HDCAD_OVERRIDED_DATE AS HOME_DET_CURF_ACTUAL_DATE,
    APD_OVERRIDED_DATE AS APPROVED_PAROLE_DATE,
    ETD AS EARLY_TERM_DATE,
    MTD AS MID_TERM_DATE,
    LTD AS LATE_TERM_DATE,
    ARD_OVERRIDED_DATE,
    ARD_CALCULATED_DATE,
    CRD_OVERRIDED_DATE,
    CRD_CALCULATED_DATE,
    NPD_OVERRIDED_DATE,
    NPD_CALCULATED_DATE,
    PRRD_OVERRIDED_DATE,
    PRRD_CALCULATED_DATE,
    (SELECT SUM(ADJUST_DAYS)
     FROM OFFENDER_KEY_DATE_ADJUSTS OKDA
     WHERE OKDA.SENTENCE_ADJUST_CODE = 'ADA'
     AND OKDA.OFFENDER_BOOK_ID = OB.OFFENDER_BOOK_ID
     GROUP BY OKDA.OFFENDER_BOOK_ID) AS ADDITIONAL_DAYS_AWARDED
  FROM
    (SELECT OSC.OFFENDER_BOOK_ID,
            CALCULATION_DATE,
            COALESCE(SED_OVERRIDED_DATE, SED_CALCULATED_DATE) AS SED,
            COALESCE(LED_OVERRIDED_DATE, LED_CALCULATED_DATE) AS LED,
            COALESCE(PED_OVERRIDED_DATE, PED_CALCULATED_DATE) AS PED,
            COALESCE(HDCED_OVERRIDED_DATE, HDCED_CALCULATED_DATE) AS HDCED,
            COALESCE(ETD_OVERRIDED_DATE, ETD_CALCULATED_DATE) AS ETD,
            COALESCE(MTD_OVERRIDED_DATE, MTD_CALCULATED_DATE) AS MTD,
            COALESCE(LTD_OVERRIDED_DATE, LTD_CALCULATED_DATE) AS LTD,
            HDCAD_OVERRIDED_DATE,
            APD_OVERRIDED_DATE,
            ARD_OVERRIDED_DATE,
            ARD_CALCULATED_DATE,
            CRD_OVERRIDED_DATE,
            CRD_CALCULATED_DATE,
            NPD_OVERRIDED_DATE,
            NPD_CALCULATED_DATE,
            PRRD_OVERRIDED_DATE,
            PRRD_CALCULATED_DATE
     FROM OFFENDER_SENT_CALCULATIONS OSC
       INNER JOIN (SELECT OFFENDER_BOOK_ID, MAX(CALCULATION_DATE) AS MAX_CALC_DATE
                   FROM OFFENDER_SENT_CALCULATIONS
                   GROUP BY OFFENDER_BOOK_ID) LATEST_OSC
         ON OSC.OFFENDER_BOOK_ID = LATEST_OSC.OFFENDER_BOOK_ID
            AND OSC.CALCULATION_DATE = LATEST_OSC.MAX_CALC_DATE) CALC_DATES
    RIGHT JOIN OFFENDER_BOOKINGS OB ON CALC_DATES.OFFENDER_BOOK_ID = OB.OFFENDER_BOOK_ID
  WHERE OB.OFFENDER_BOOK_ID = :bookingId
}

GET_BOOKING_ACTIVITIES {
  SELECT OPP.OFFENDER_BOOK_ID AS BOOKING_ID,
	       'INT_MOV' AS EVENT_CLASS,
	       COALESCE(OCA.EVENT_STATUS, 'SCH') AS EVENT_STATUS,
         'PRISON_ACT' AS EVENT_TYPE,
         RD1.DESCRIPTION AS EVENT_TYPE_DESC,
	       CA.COURSE_ACTIVITY_TYPE AS EVENT_SUB_TYPE,
	       RD2.DESCRIPTION AS EVENT_SUB_TYPE_DESC,
	       CS.SCHEDULE_DATE AS EVENT_DATE,
	       CS.START_TIME,
	       CS.END_TIME,
         COALESCE(AIL.USER_DESC, AIL.DESCRIPTION, AGY.DESCRIPTION, ADDR.STREET) AS EVENT_LOCATION,
         'PA' AS EVENT_SOURCE,
         CA.CODE AS EVENT_SOURCE_CODE,
         CA.DESCRIPTION AS EVENT_SOURCE_DESC
  FROM OFFENDER_PROGRAM_PROFILES OPP
    INNER JOIN OFFENDER_BOOKINGS OB ON OB.OFFENDER_BOOK_ID = OPP.OFFENDER_BOOK_ID AND OB.ACTIVE_FLAG = 'Y'
    INNER JOIN COURSE_ACTIVITIES CA ON CA.CRS_ACTY_ID = OPP.CRS_ACTY_ID
    INNER JOIN COURSE_SCHEDULES CS ON OPP.CRS_ACTY_ID = CS.CRS_ACTY_ID
      AND CS.SCHEDULE_DATE >= TRUNC(OPP.OFFENDER_START_DATE)
      AND TRUNC(CS.SCHEDULE_DATE) <= COALESCE(OPP.OFFENDER_END_DATE, CA.SCHEDULE_END_DATE, CS.SCHEDULE_DATE)
      AND CS.SCHEDULE_DATE >= TRUNC(COALESCE(:fromDate, CS.SCHEDULE_DATE))
      AND TRUNC(CS.SCHEDULE_DATE) <= COALESCE(:toDate, CS.SCHEDULE_DATE)
    LEFT JOIN OFFENDER_COURSE_ATTENDANCES OCA ON OCA.OFFENDER_BOOK_ID = OPP.OFFENDER_BOOK_ID
      AND TRUNC(OCA.EVENT_DATE) = TRUNC(CS.SCHEDULE_DATE)
      AND OCA.CRS_SCH_ID = CS.CRS_SCH_ID
    LEFT JOIN REFERENCE_CODES RD1 ON RD1.CODE = 'PRISON_ACT' AND RD1.DOMAIN = 'INT_SCH_TYPE'
    LEFT JOIN REFERENCE_CODES RD2 ON RD2.CODE = CA.COURSE_ACTIVITY_TYPE AND RD2.DOMAIN = 'INT_SCH_RSN'
    LEFT JOIN AGENCY_INTERNAL_LOCATIONS AIL ON CA.INTERNAL_LOCATION_ID = AIL.INTERNAL_LOCATION_ID
    LEFT JOIN AGENCY_LOCATIONS AGY ON CA.AGY_LOC_ID = AGY.AGY_LOC_ID
    LEFT JOIN ADDRESSES ADDR ON CA.SERVICES_ADDRESS_ID = ADDR.ADDRESS_ID
  WHERE OPP.OFFENDER_BOOK_ID = :bookingId
    AND OPP.OFFENDER_PROGRAM_STATUS = 'ALLOC'
    AND COALESCE(OPP.SUSPENDED_FLAG, 'N') = 'N'
    AND CA.ACTIVE_FLAG = 'Y'
    AND CA.COURSE_ACTIVITY_TYPE IS NOT NULL
    AND CS.CATCH_UP_CRS_SCH_ID IS NULL
}

GET_BOOKING_IEP_DETAILS {
  SELECT OIL.OFFENDER_BOOK_ID BOOKING_ID,
         IEP_DATE,
         IEP_TIME,
         OIL.AGY_LOC_ID AGENCY_ID,
         COALESCE(RC.DESCRIPTION, OIL.IEP_LEVEL) AS IEP_LEVEL,
         COMMENT_TEXT,
         USER_ID
  FROM OFFENDER_IEP_LEVELS OIL
    INNER JOIN OFFENDER_BOOKINGS OB ON OIL.OFFENDER_BOOK_ID = OB.OFFENDER_BOOK_ID
    LEFT JOIN REFERENCE_CODES RC ON RC.CODE = OIL.IEP_LEVEL AND RC.DOMAIN = 'IEP_LEVEL'
  WHERE OB.OFFENDER_BOOK_ID = :bookingId
  ORDER BY OIL.IEP_DATE DESC, OIL.IEP_LEVEL_SEQ DESC
}

CHECK_BOOKING_AGENCIES {
  SELECT OFFENDER_BOOK_ID
  FROM OFFENDER_BOOKINGS
  WHERE ACTIVE_FLAG = 'Y'
  AND OFFENDER_BOOK_ID = :bookingId
  AND AGY_LOC_ID IN (:agencyIds)
}

OFFENDER_SUMMARY {
  SELECT
    OB.OFFENDER_BOOK_ID   AS                          booking_id,
    O.OFFENDER_ID_DISPLAY AS                          offender_no,
    O.TITLE,
    O.SUFFIX,
    O.FIRST_NAME,
    CONCAT(O.middle_name, CASE WHEN middle_name_2 IS NOT NULL
      THEN concat(' ', O.middle_name_2)
                          ELSE '' END)                MIDDLE_NAMES,
    O.LAST_NAME,
    OB.ACTIVE_FLAG        AS                          currently_in_prison,
    ob.agy_loc_id         AS                          agency_location_id,
    al.description                                    agency_location_desc,
    OB.LIVING_UNIT_ID     AS                          internal_location_id,
    AIL.DESCRIPTION       AS                          internal_location_desc,
    COALESCE(ord.release_date, ord.auto_release_date) RELEASE_DATE
  FROM OFFENDERS O
    JOIN OFFENDER_BOOKINGS OB
      ON OB.offender_id = o.offender_id
         AND OB.booking_seq = 1
    JOIN agency_locations al
      ON al.agy_loc_id = ob.agy_loc_id
    LEFT JOIN AGENCY_INTERNAL_LOCATIONS AIL ON OB.LIVING_UNIT_ID = AIL.INTERNAL_LOCATION_ID
    LEFT JOIN offender_release_details ord
      ON ord.offender_book_id = ob.offender_book_id
  WHERE COALESCE(ord.release_date, ord.auto_release_date) <= :toReleaseDate
    AND OB.ACTIVE_FLAG = 'Y'
}

GET_BOOKING_VISITS {
  SELECT VIS.OFFENDER_BOOK_ID AS BOOKING_ID,
	       'INT_MOV' AS EVENT_CLASS,
	       'SCH' AS EVENT_STATUS,
         'VISIT' AS EVENT_TYPE,
         RC1.DESCRIPTION AS EVENT_TYPE_DESC,
	       'VISIT' AS EVENT_SUB_TYPE,
	       RC2.DESCRIPTION AS EVENT_SUB_TYPE_DESC,
	       VIS.VISIT_DATE AS EVENT_DATE,
	       VIS.START_TIME,
	       VIS.END_TIME,
         COALESCE(AIL.USER_DESC, AIL.DESCRIPTION, AGY.DESCRIPTION) AS EVENT_LOCATION,
         'VIS' AS EVENT_SOURCE,
         VIS.VISIT_TYPE AS EVENT_SOURCE_CODE,
         RC3.DESCRIPTION AS EVENT_SOURCE_DESC
  FROM OFFENDER_VISITS VIS
    INNER JOIN OFFENDER_BOOKINGS OB ON OB.OFFENDER_BOOK_ID = VIS.OFFENDER_BOOK_ID AND OB.ACTIVE_FLAG = 'Y'
    LEFT JOIN REFERENCE_CODES RC1 ON RC1.CODE = 'VISIT' AND RC1.DOMAIN = 'INT_SCH_TYPE'
    LEFT JOIN REFERENCE_CODES RC2 ON RC2.CODE = 'VISIT' AND RC2.DOMAIN = 'INT_SCH_RSN'
    LEFT JOIN REFERENCE_CODES RC3 ON RC3.CODE = VIS.VISIT_TYPE AND RC3.DOMAIN = 'VISIT_TYPE'
    LEFT JOIN AGENCY_INTERNAL_LOCATIONS AIL ON VIS.VISIT_INTERNAL_LOCATION_ID = AIL.INTERNAL_LOCATION_ID
    LEFT JOIN AGENCY_LOCATIONS AGY ON VIS.AGY_LOC_ID = AGY.AGY_LOC_ID
  WHERE VIS.OFFENDER_BOOK_ID = :bookingId
    AND VIS.VISIT_STATUS = 'SCH'
    AND VIS.VISIT_DATE >= TRUNC(COALESCE(:fromDate, VIS.VISIT_DATE))
    AND TRUNC(VIS.VISIT_DATE) <= COALESCE(:toDate, VIS.VISIT_DATE)
}

GET_BOOKING_APPOINTMENTS {
  SELECT OIS.OFFENDER_BOOK_ID AS BOOKING_ID,
	       OIS.EVENT_CLASS,
	       OIS.EVENT_STATUS,
         OIS.EVENT_TYPE,
         RC1.DESCRIPTION AS EVENT_TYPE_DESC,
	       OIS.EVENT_SUB_TYPE,
	       RC2.DESCRIPTION AS EVENT_SUB_TYPE_DESC,
	       OIS.EVENT_DATE,
	       OIS.START_TIME,
	       OIS.END_TIME,
         COALESCE(AIL.USER_DESC, AIL.DESCRIPTION, AGY.DESCRIPTION, ADDR.STREET, RC3.DESCRIPTION) AS EVENT_LOCATION,
         'APP' AS EVENT_SOURCE
  FROM OFFENDER_IND_SCHEDULES OIS
    INNER JOIN OFFENDER_BOOKINGS OB ON OB.OFFENDER_BOOK_ID = OIS.OFFENDER_BOOK_ID AND OB.ACTIVE_FLAG = 'Y'
    LEFT JOIN REFERENCE_CODES RC1 ON RC1.CODE = OIS.EVENT_TYPE AND RC1.DOMAIN = 'INT_SCH_TYPE'
    LEFT JOIN REFERENCE_CODES RC2 ON RC2.CODE = OIS.EVENT_SUB_TYPE AND RC2.DOMAIN = 'INT_SCH_RSN'
    LEFT JOIN AGENCY_INTERNAL_LOCATIONS AIL ON OIS.TO_INTERNAL_LOCATION_ID = AIL.INTERNAL_LOCATION_ID
    LEFT JOIN AGENCY_LOCATIONS AGY ON OIS.TO_AGY_LOC_ID = AGY.AGY_LOC_ID
    LEFT JOIN ADDRESSES ADDR ON OIS.TO_ADDRESS_ID = ADDR.ADDRESS_ID
    LEFT JOIN REFERENCE_CODES RC3 ON RC3.CODE = OIS.TO_CITY_CODE AND RC3.DOMAIN = 'CITY'
  WHERE OIS.OFFENDER_BOOK_ID = :bookingId
    AND OIS.EVENT_TYPE = 'APP'
    AND OIS.EVENT_STATUS = 'SCH'
    AND OIS.EVENT_DATE >= TRUNC(COALESCE(:fromDate, OIS.EVENT_DATE))
    AND TRUNC(OIS.EVENT_DATE) <= COALESCE(:toDate, OIS.EVENT_DATE)
}

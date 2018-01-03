
GET_ACTIVITIES_AT_LOCATION {
  SELECT O.OFFENDER_ID_DISPLAY AS OFFENDER_NO,
         O.FIRST_NAME,
         O.LAST_NAME, 
         AIL.DESCRIPTION AS cell_Location,
         CA.COURSE_ACTIVITY_TYPE AS EVENT,
         RD2.DESCRIPTION AS EVENT_DESCRIPTION,
         CS.START_TIME,
         CS.END_TIME,
         CA.DESCRIPTION AS COMMENT
  FROM OFFENDER_PROGRAM_PROFILES OPP
    INNER JOIN OFFENDER_BOOKINGS OB ON OB.OFFENDER_BOOK_ID = OPP.OFFENDER_BOOK_ID AND OB.ACTIVE_FLAG = 'Y'
    INNER JOIN OFFENDERS O ON OB.OFFENDER_ID = O.OFFENDER_ID
    INNER JOIN AGENCY_INTERNAL_LOCATIONS AIL ON OB.LIVING_UNIT_ID = AIL.INTERNAL_LOCATION_ID
    INNER JOIN COURSE_ACTIVITIES CA ON CA.CRS_ACTY_ID = OPP.CRS_ACTY_ID
    INNER JOIN COURSE_SCHEDULES CS ON CA.CRS_ACTY_ID = CS.CRS_ACTY_ID
      AND CS.SCHEDULE_DATE >= TRUNC(OPP.OFFENDER_START_DATE)
      AND TRUNC(CS.SCHEDULE_DATE) <= COALESCE(OPP.OFFENDER_END_DATE, CA.SCHEDULE_END_DATE, CS.SCHEDULE_DATE)
      AND CS.SCHEDULE_DATE >= TRUNC(COALESCE(:fromDate, CS.SCHEDULE_DATE))
      AND TRUNC(CS.SCHEDULE_DATE) <= COALESCE(:toDate, CS.SCHEDULE_DATE)
    LEFT JOIN REFERENCE_CODES RD2 ON RD2.CODE = CA.COURSE_ACTIVITY_TYPE AND RD2.DOMAIN = 'INT_SCH_RSN'
  WHERE CA.INTERNAL_LOCATION_ID = :locationId
    AND OPP.OFFENDER_PROGRAM_STATUS = 'ALLOC'
    AND COALESCE(OPP.SUSPENDED_FLAG, 'N') = 'N'
    AND CA.ACTIVE_FLAG = 'Y'
    AND CA.COURSE_ACTIVITY_TYPE IS NOT NULL
    AND CS.CATCH_UP_CRS_SCH_ID IS NULL
}

DUFF{
  SELECT B.OFFENDER_BOOK_ID AS BOOKING_ID,
         O.OFFENDER_ID_DISPLAY AS OFFENDER_NO,
         O.FIRST_NAME,
         O.LAST_NAME, 
         B.LIVING_UNIT_ID AS LOCATION_ID,
         AIL.DESCRIPTION AS LOCATION_DESCRIPTION
  FROM OFFENDER_BOOKINGS B
    INNER JOIN OFFENDERS O ON B.OFFENDER_ID = O.OFFENDER_ID
    INNER JOIN AGENCY_INTERNAL_LOCATIONS AIL ON B.LIVING_UNIT_ID = AIL.INTERNAL_LOCATION_ID
  WHERE B.ACTIVE_FLAG = 'Y'
  AND EXISTS (select 1 from CASELOAD_AGENCY_LOCATIONS C WHERE B.AGY_LOC_ID = C.AGY_LOC_ID AND C.CASELOAD_ID IN (:caseLoadIds))
  AND AIL.INTERNAL_LOCATION_ID in (:locations)
  AND B.AGY_LOC_ID = :agencyId
    private String offenderNo;
    private String firstName;
    private String lastName;
    private String cellLocation;
    
    private String event;
    private String eventDescription;
    private String comment;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
}

GET_APPOINTMENTS_AT_LOCATION {
  SELECT O.OFFENDER_ID_DISPLAY AS OFFENDER_NO,
         O.FIRST_NAME,
         O.LAST_NAME, 
         AIL.DESCRIPTION AS cell_Location,
         OIS.EVENT_SUB_TYPE AS EVENT,
         RC2.DESCRIPTION AS EVENT_DESCRIPTION,
         OIS.START_TIME,
         OIS.END_TIME,
         OIS.COMMENT_TEXT AS COMMENT
  FROM OFFENDER_IND_SCHEDULES OIS
    INNER JOIN OFFENDER_BOOKINGS OB ON OB.OFFENDER_BOOK_ID = OIS.OFFENDER_BOOK_ID AND OB.ACTIVE_FLAG = 'Y'
    INNER JOIN OFFENDERS O ON OB.OFFENDER_ID = O.OFFENDER_ID
    INNER JOIN AGENCY_INTERNAL_LOCATIONS AIL ON OB.LIVING_UNIT_ID = AIL.INTERNAL_LOCATION_ID
    LEFT JOIN REFERENCE_CODES RC2 ON RC2.CODE = OIS.EVENT_SUB_TYPE AND RC2.DOMAIN = 'INT_SCH_RSN'
  WHERE OIS.TO_INTERNAL_LOCATION_ID = :locationId
    AND OIS.EVENT_TYPE = 'APP'
    AND OIS.EVENT_STATUS = 'SCH'
    AND OIS.EVENT_DATE >= TRUNC(COALESCE(:fromDate, OIS.EVENT_DATE))
    AND TRUNC(OIS.EVENT_DATE) <= COALESCE(:toDate, OIS.EVENT_DATE)
}

GET_VISITS_AT_LOCATION {
  SELECT O.OFFENDER_ID_DISPLAY AS OFFENDER_NO,
         O.FIRST_NAME,
         O.LAST_NAME, 
         AIL.DESCRIPTION AS CELL_LOCATION,
	     'VISIT' AS EVENT,
	     RC2.DESCRIPTION AS EVENT_DESCRIPTION,
	     VIS.START_TIME,
	     VIS.END_TIME,
         RC3.DESCRIPTION AS COMMENT
  FROM OFFENDER_VISITS VIS
    INNER JOIN OFFENDER_BOOKINGS OB ON OB.OFFENDER_BOOK_ID = VIS.OFFENDER_BOOK_ID AND OB.ACTIVE_FLAG = 'Y'
    INNER JOIN OFFENDERS O ON OB.OFFENDER_ID = O.OFFENDER_ID
    INNER JOIN AGENCY_INTERNAL_LOCATIONS AIL ON OB.LIVING_UNIT_ID = AIL.INTERNAL_LOCATION_ID
    LEFT JOIN REFERENCE_CODES RC2 ON RC2.CODE = 'VISIT' AND RC2.DOMAIN = 'INT_SCH_RSN'
    LEFT JOIN REFERENCE_CODES RC3 ON RC3.CODE = VIS.VISIT_TYPE AND RC3.DOMAIN = 'VISIT_TYPE'
  WHERE VIS.VISIT_INTERNAL_LOCATION_ID = :locationId
    AND VIS.VISIT_STATUS = 'SCH'
    AND VIS.VISIT_DATE >= TRUNC(COALESCE(:fromDate, VIS.VISIT_DATE))
    AND TRUNC(VIS.VISIT_DATE) <= COALESCE(:toDate, VIS.VISIT_DATE)
}

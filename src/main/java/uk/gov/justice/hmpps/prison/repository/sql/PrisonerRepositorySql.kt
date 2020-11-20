package uk.gov.justice.hmpps.prison.repository.sql

enum class PrisonerRepositorySql(val sql: String) {
  SEARCH_OFFENDERS(
    """
        SELECT
        O.OFFENDER_ID_DISPLAY OFFENDER_NO,
        O.TITLE TITLE,
        O.SUFFIX SUFFIX,
        O.FIRST_NAME FIRST_NAME,
        CONCAT (O.MIDDLE_NAME, CASE WHEN MIDDLE_NAME_2 IS NOT NULL THEN CONCAT (' ', O.MIDDLE_NAME_2) ELSE '' END) MIDDLE_NAMES,
        O.LAST_NAME LAST_NAME,
        O.BIRTH_DATE DATE_OF_BIRTH,
        RCE.DESCRIPTION ETHNICITY,
        RCS.DESCRIPTION GENDER,
        RCC.DESCRIPTION BIRTH_COUNTRY,
        OB.OFFENDER_BOOK_ID LATEST_BOOKING_ID,
        OB.BOOKING_BEGIN_DATE RECEPTION_DATE,
        OB.ACTIVE_FLAG CURRENTLY_IN_PRISON,
        OB.AGY_LOC_ID LATEST_LOCATION_ID,
        AL.DESCRIPTION LATEST_LOCATION,
        IST.BAND_CODE,
        CASE WHEN OPD2.PROFILE_CODE IS NOT NULL THEN OPD2.PROFILE_CODE ELSE PC1.DESCRIPTION END NATIONALITIES,
        PC3.DESCRIPTION RELIGION,
        PC2.DESCRIPTION MARITAL_STATUS,
        OIS.IMPRISONMENT_STATUS,
        OI1.IDENTIFIER PNC_NUMBER,
        OI2.IDENTIFIER CRO_NUMBER
        FROM OFFENDERS O
        INNER JOIN OFFENDER_BOOKINGS OB ON OB.OFFENDER_ID = O.OFFENDER_ID AND OB.BOOKING_SEQ = 1
        INNER JOIN AGENCY_LOCATIONS AL ON AL.AGY_LOC_ID = OB.AGY_LOC_ID
        LEFT JOIN OFFENDER_IDENTIFIERS OI1 ON OI1.OFFENDER_ID = OB.OFFENDER_ID AND OI1.IDENTIFIER_TYPE = 'PNC'
        LEFT JOIN OFFENDER_IDENTIFIERS OI2 ON OI2.OFFENDER_ID = OB.OFFENDER_ID AND OI2.IDENTIFIER_TYPE = 'CRO'
        LEFT JOIN OFFENDER_IMPRISON_STATUSES OIS ON OIS.OFFENDER_BOOK_ID = OB.OFFENDER_BOOK_ID AND OIS.LATEST_STATUS = 'Y'
        LEFT JOIN IMPRISONMENT_STATUSES IST ON IST.IMPRISONMENT_STATUS = OIS.IMPRISONMENT_STATUS
        LEFT JOIN REFERENCE_CODES RCE ON O.RACE_CODE = RCE.CODE AND RCE.DOMAIN = 'ETHNICITY'
        LEFT JOIN REFERENCE_CODES RCS ON O.SEX_CODE = RCS.CODE AND RCS.DOMAIN = 'SEX'
        LEFT JOIN REFERENCE_CODES RCC ON O.BIRTH_COUNTRY_CODE = RCC.CODE AND RCC.DOMAIN = 'COUNTRY'
        LEFT JOIN OFFENDER_PROFILE_DETAILS OPD1 ON OPD1.OFFENDER_BOOK_ID = OB.OFFENDER_BOOK_ID AND OPD1.PROFILE_TYPE = 'NAT'
        LEFT JOIN OFFENDER_PROFILE_DETAILS OPD2 ON OPD2.OFFENDER_BOOK_ID = OB.OFFENDER_BOOK_ID AND OPD2.PROFILE_TYPE = 'NATIO'
        LEFT JOIN OFFENDER_PROFILE_DETAILS OPD3 ON OPD3.OFFENDER_BOOK_ID = OB.OFFENDER_BOOK_ID AND OPD3.PROFILE_TYPE = 'RELF'
        LEFT JOIN OFFENDER_PROFILE_DETAILS OPD4 ON OPD4.OFFENDER_BOOK_ID = OB.OFFENDER_BOOK_ID AND OPD4.PROFILE_TYPE = 'MARITAL'
        LEFT JOIN PROFILE_CODES PC1 ON PC1.PROFILE_TYPE = OPD1.PROFILE_TYPE AND PC1.PROFILE_CODE = OPD1.PROFILE_CODE
        LEFT JOIN PROFILE_CODES PC2 ON PC2.PROFILE_TYPE = OPD4.PROFILE_TYPE AND PC2.PROFILE_CODE = OPD4.PROFILE_CODE
        LEFT JOIN PROFILE_CODES PC3 ON PC3.PROFILE_TYPE = OPD3.PROFILE_TYPE AND PC3.PROFILE_CODE = OPD3.PROFILE_CODE
    """
  ),

  LIST_ALL_OFFENDERS(
    """
        SELECT DISTINCT OFFENDER_ID_DISPLAY OFFENDER_NUMBER FROM OFFENDERS ORDER BY OFFENDER_ID_DISPLAY ASC
    """
  ),

  GET_OFFENDER_IDS(
    """
        SELECT OFFENDER_ID FROM OFFENDERS WHERE OFFENDER_ID_DISPLAY = :offenderNo
    """
  )
}
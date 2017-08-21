FIND_INMATE_DETAIL {
  SELECT B.OFFENDER_BOOK_ID,
         B.BOOKING_NO,
         O.OFFENDER_ID_DISPLAY,
         O.FIRST_NAME,
         O.MIDDLE_NAME,
         O.LAST_NAME,
         (SELECT * FROM
           (SELECT IMAGE_ID
            FROM IMAGES
            WHERE ACTIVE_FLAG = 'Y'
            AND IMAGE_OBJECT_TYPE = 'OFF_BKG'
            AND IMAGE_OBJECT_ID = B.OFFENDER_BOOK_ID
            AND IMAGE_VIEW_TYPE = 'FACE'
            AND ORIENTATION_TYPE = 'FRONT'
            ORDER BY CREATE_DATETIME DESC)
          WHERE ROWNUM <= 1) AS FACE_IMAGE_ID,
         O.BIRTH_DATE,
         TRUNC(MONTHS_BETWEEN(sysdate, O.BIRTH_DATE)/12) AS AGE,
         B.ASSIGNED_STAFF_ID AS ASSIGNED_OFFICER_ID
  FROM OFFENDER_BOOKINGS B
    INNER JOIN OFFENDERS O ON B.OFFENDER_ID = O.OFFENDER_ID
    INNER JOIN CASELOAD_AGENCY_LOCATIONS C ON B.AGY_LOC_ID = C.AGY_LOC_ID AND C.CASELOAD_ID = :caseLoadId
  WHERE B.ACTIVE_FLAG = 'Y' AND B.OFFENDER_BOOK_ID = :bookingId
}

FIND_ALERT_TYPES_FOR_OFFENDER {
   SELECT DISTINCT(ALERT_TYPE) AS ALERT_TYPE
   FROM OFFENDER_ALERTS A
   WHERE A.OFFENDER_BOOK_ID = :bookingId AND A.ALERT_STATUS = 'ACTIVE' ORDER BY ALERT_TYPE
}

FIND_ASSIGNED_LIVING_UNIT {
     SELECT B.AGY_LOC_ID,
            B.LIVING_UNIT_ID,
            I.DESCRIPTION LIVING_UNIT_DESCRITION
       FROM OFFENDER_BOOKINGS B
            LEFT JOIN AGENCY_INTERNAL_LOCATIONS I ON B.LIVING_UNIT_ID = I.INTERNAL_LOCATION_ID
      WHERE B.ACTIVE_FLAG = 'Y' AND B.OFFENDER_BOOK_ID = :bookingId
}

FIND_ALL_INMATES {
  SELECT B.OFFENDER_BOOK_ID,
         B.BOOKING_NO,
         O.OFFENDER_ID_DISPLAY,
         B.AGY_LOC_ID,
         O.FIRST_NAME,
         O.MIDDLE_NAME,
         O.LAST_NAME,
         O.BIRTH_DATE,
         TRUNC(MONTHS_BETWEEN(sysdate, O.BIRTH_DATE)/12) AS AGE,
         (SELECT LISTAGG(ALERT_TYPE, ',') WITHIN GROUP (ORDER BY ALERT_TYPE)
          FROM (SELECT DISTINCT(ALERT_TYPE)
                FROM OFFENDER_ALERTS A
                WHERE B.OFFENDER_BOOK_ID = A.OFFENDER_BOOK_ID AND A.ALERT_STATUS = 'ACTIVE')) AS ALERT_TYPES,
         B.LIVING_UNIT_ID,
         AIL.DESCRIPTION AS LIVING_UNIT_DESC,
         (SELECT *
          FROM (SELECT IMAGE_ID
                FROM IMAGES
                WHERE ACTIVE_FLAG = 'Y'
                AND IMAGE_OBJECT_TYPE = 'OFF_BKG'
                AND IMAGE_OBJECT_ID = B.OFFENDER_BOOK_ID
                AND IMAGE_VIEW_TYPE = 'FACE'
                AND ORIENTATION_TYPE = 'FRONT'
                ORDER BY CREATE_DATETIME DESC)
          WHERE ROWNUM <= 1) AS FACE_IMAGE_ID,
         S.USER_ID AS ASSIGNED_OFFICER_ID
  FROM OFFENDER_BOOKINGS B
    INNER JOIN OFFENDERS O ON B.OFFENDER_ID = O.OFFENDER_ID
    INNER JOIN CASELOAD_AGENCY_LOCATIONS C ON B.AGY_LOC_ID = C.AGY_LOC_ID AND C.CASELOAD_ID IN (:caseLoadId)
    LEFT JOIN AGENCY_INTERNAL_LOCATIONS AIL ON B.LIVING_UNIT_ID = AIL.INTERNAL_LOCATION_ID
    LEFT JOIN STAFF_MEMBERS S ON B.ASSIGNED_STAFF_ID = S.STAFF_ID
  WHERE B.ACTIVE_FLAG = 'Y'
}

FIND_INMATES_BY_LOCATION {
     SELECT B.OFFENDER_BOOK_ID,
            B.BOOKING_NO,
            O.OFFENDER_ID_DISPLAY,
            B.AGY_LOC_ID,
            O.FIRST_NAME,
            O.MIDDLE_NAME,
            O.LAST_NAME,
            O.BIRTH_DATE,
            TRUNC(MONTHS_BETWEEN(sysdate, O.BIRTH_DATE)/12) AS AGE,
            (
                SELECT LISTAGG(ALERT_TYPE, ',') WITHIN GROUP (ORDER BY ALERT_TYPE)
                  FROM (
                            SELECT DISTINCT( ALERT_TYPE)
                              FROM OFFENDER_ALERTS A
                             WHERE B.OFFENDER_BOOK_ID = A.OFFENDER_BOOK_ID AND A.ALERT_STATUS = 'ACTIVE'
                       )
            ) AS ALERT_TYPES,
            B.LIVING_UNIT_ID,
            (
                SELECT * FROM (
                    SELECT IMAGE_ID
                      FROM IMAGES
                     WHERE ACTIVE_FLAG = 'Y'
                           AND IMAGE_OBJECT_TYPE = 'OFF_BKG'
                           AND IMAGE_OBJECT_ID = B.OFFENDER_BOOK_ID
                           AND IMAGE_VIEW_TYPE = 'FACE'
                           AND ORIENTATION_TYPE = 'FRONT'
                     ORDER BY CREATE_DATETIME DESC
                )
                WHERE ROWNUM <= 1
            ) AS FACE_IMAGE_ID
       FROM OFFENDER_BOOKINGS B
            INNER JOIN CASELOAD_AGENCY_LOCATIONS C ON C.CASELOAD_ID = :caseLoadId AND B.AGY_LOC_ID = C.AGY_LOC_ID
            LEFT JOIN OFFENDERS O ON B.OFFENDER_ID = O.OFFENDER_ID
      WHERE B.ACTIVE_FLAG = 'Y'
            AND B.LIVING_UNIT_ID IN (
                SELECT INTERNAL_LOCATION_ID
                  FROM AGENCY_INTERNAL_LOCATIONS START WITH INTERNAL_LOCATION_ID = :locationId
               CONNECT BY PRIOR INTERNAL_LOCATION_ID = PARENT_INTERNAL_LOCATION_ID
            )

}

FIND_PHYSICAL_CHARACTERISTICS_BY_BOOKING {
  select PT.DESCRIPTION AS CHARACTERISTIC, COALESCE(PC.DESCRIPTION, P.PROFILE_CODE) AS DETAIL,
         (SELECT I.IMAGE_ID
          FROM IMAGES I
          WHERE I.ACTIVE_FLAG = 'Y'
                AND IMAGE_OBJECT_TYPE = 'OFF_BKG'
                AND IMAGE_OBJECT_ID = B.OFFENDER_BOOK_ID
                AND IMAGE_VIEW_TYPE = P.PROFILE_TYPE
                AND CREATE_DATETIME = (SELECT MAX(CREATE_DATETIME)
                                       FROM IMAGES
                                       WHERE ACTIVE_FLAG = 'Y'
                                             AND IMAGE_OBJECT_TYPE = 'OFF_BKG'
                                             AND IMAGE_OBJECT_ID = I.IMAGE_OBJECT_ID
                                             AND IMAGE_VIEW_TYPE = P.PROFILE_TYPE) ) AS IMAGE_ID
  from OFFENDER_PROFILE_DETAILS P
    JOIN OFFENDER_BOOKINGS B ON B.OFFENDER_BOOK_ID = P.OFFENDER_BOOK_ID
    JOIN CASELOAD_AGENCY_LOCATIONS C ON C.CASELOAD_ID = :caseLoadId AND B.AGY_LOC_ID = C.AGY_LOC_ID
    JOIN PROFILE_TYPES PT ON PT.PROFILE_TYPE = P.PROFILE_TYPE AND PROFILE_CATEGORY = 'PA'
    LEFT JOIN PROFILE_CODES PC ON PC.PROFILE_TYPE = PT.PROFILE_TYPE AND PC.PROFILE_CODE = P.PROFILE_CODE
  where P.OFFENDER_BOOK_ID = :bookingId
}

FIND_PHYSICAL_MARKS_BY_BOOKING {
    SELECT (SELECT DESCRIPTION FROM REFERENCE_CODES WHERE CODE = M.MARK_TYPE AND DOMAIN='MARK_TYPE') AS TYPE,
           (SELECT DESCRIPTION FROM REFERENCE_CODES WHERE CODE = M.SIDE_CODE AND DOMAIN='SIDE') AS SIDE,
           (SELECT DESCRIPTION FROM REFERENCE_CODES WHERE CODE = M.BODY_PART_CODE AND DOMAIN='BODY_PART') AS BODY_PART,
           (SELECT DESCRIPTION FROM REFERENCE_CODES WHERE CODE = M.PART_ORIENTATION_CODE AND DOMAIN='PART_ORIENT') AS ORENTIATION,
           M.COMMENT_TEXT,
           (SELECT I.IMAGE_ID
              FROM IMAGES I
             WHERE B.OFFENDER_BOOK_ID = :bookingId
                   AND B.OFFENDER_BOOK_ID = I.IMAGE_OBJECT_ID
                   AND I.ACTIVE_FLAG = 'Y'
                   AND M.MARK_TYPE = I.IMAGE_VIEW_TYPE
                   AND M.BODY_PART_CODE = I.ORIENTATION_TYPE
                   AND M.ID_MARK_SEQ = I.IMAGE_OBJECT_SEQ
           ) AS IMAGE_ID
      FROM OFFENDER_BOOKINGS B
           INNER JOIN CASELOAD_AGENCY_LOCATIONS C ON C.CASELOAD_ID = :caseLoadId AND B.AGY_LOC_ID = C.AGY_LOC_ID
           INNER JOIN offender_identifying_marks M ON B.OFFENDER_BOOK_ID = M.OFFENDER_BOOK_ID
     WHERE B.OFFENDER_BOOK_ID = :bookingId
           AND B.ACTIVE_FLAG = 'Y'
           AND M.BODY_PART_CODE != 'CONV'
}

FIND_PHYSICAL_ATTRIBUTES_BY_BOOKING {
    SELECT O.SEX_CODE,
           O.RACE_CODE,
           P.HEIGHT_FT,
           P.HEIGHT_IN,
           P.HEIGHT_CM,
           P.WEIGHT_LBS,
           P.WEIGHT_KG
      FROM OFFENDER_BOOKINGS B
           INNER JOIN CASELOAD_AGENCY_LOCATIONS C ON C.CASELOAD_ID = :caseLoadId AND B.AGY_LOC_ID = C.AGY_LOC_ID
           LEFT JOIN OFFENDERS O ON B.OFFENDER_ID = O.OFFENDER_ID
           LEFT JOIN OFFENDER_PHYSICAL_ATTRIBUTES P ON B.OFFENDER_BOOK_ID = P.OFFENDER_BOOK_ID
     WHERE B.OFFENDER_BOOK_ID = :bookingId
           AND B.ACTIVE_FLAG = 'Y'
}

FIND_ACTIVE_APPROVED_ASSESSMENT {
    SELECT ASSESSMENTS.ASSESSMENT_CODE,
           ASSESSMENTS.DESCRIPTION AS ASSESSMENT_DESCRIPTION,
           REF_CD_SUP_LVL_TYPE.DESCRIPTION AS CLASSIFICATION
      FROM OFFENDER_ASSESSMENTS,
           ASSESSMENTS,
           REFERENCE_CODES REF_CD_SUP_LVL_TYPE
     WHERE OFFENDER_ASSESSMENTS.ASSESSMENT_TYPE_ID = ASSESSMENTS.ASSESSMENT_ID
           AND ASSESSMENTS.ASSESSMENT_CLASS = 'TYPE'
           AND OFFENDER_ASSESSMENTS.OFFENDER_BOOK_ID = :bookingId
           AND OFFENDER_ASSESSMENTS.REVIEW_SUP_LEVEL_TYPE = REF_CD_SUP_LVL_TYPE.CODE
           AND REF_CD_SUP_LVL_TYPE.DOMAIN = 'SUP_LVL_TYPE'
           AND OFFENDER_ASSESSMENTS.ASSESS_STATUS = 'A'
           AND OFFENDER_ASSESSMENTS.EVALUATION_RESULT_CODE = 'APP'
}

FIND_INMATE_ALIASES {
  SELECT O.LAST_NAME,
    O.FIRST_NAME,
    O.MIDDLE_NAME,
    O.BIRTH_DATE,
    TRUNC(MONTHS_BETWEEN(SYSDATE, O.BIRTH_DATE)/12) AS AGE,
    RCE.DESCRIPTION AS ETHNICITY,
    RCS.DESCRIPTION AS SEX,
    RCNT.DESCRIPTION AS ALIAS_TYPE
  FROM OFFENDERS O
    INNER JOIN OFFENDER_BOOKINGS OB ON O.ROOT_OFFENDER_ID = OB.ROOT_OFFENDER_ID
                                       AND O.OFFENDER_ID != OB.OFFENDER_ID
    LEFT JOIN REFERENCE_CODES RCE ON O.RACE_CODE = RCE.CODE
                                     AND RCE.DOMAIN = 'ETHNICITY'
    LEFT JOIN REFERENCE_CODES RCS ON O.SEX_CODE = RCS.CODE
                                     AND RCS.DOMAIN = 'SEX'
    LEFT JOIN REFERENCE_CODES RCNT ON O.ALIAS_NAME_TYPE = RCNT.CODE
                                      AND RCNT.DOMAIN = 'NAME_TYPE'
  WHERE OB.OFFENDER_BOOK_ID = :bookingId
}

FIND_MY_ASSIGNMENTS {
  SELECT B.OFFENDER_BOOK_ID,
         B.BOOKING_NO,
         O.OFFENDER_ID_DISPLAY,
         B.AGY_LOC_ID,
         O.FIRST_NAME,
         O.MIDDLE_NAME,
         O.LAST_NAME,
         O.BIRTH_DATE,
         TRUNC(MONTHS_BETWEEN(sysdate, O.BIRTH_DATE)/12) AS AGE,
         (SELECT LISTAGG(ALERT_TYPE, ',')
          WITHIN GROUP (ORDER BY ALERT_TYPE)
          FROM (SELECT DISTINCT(ALERT_TYPE)
                FROM OFFENDER_ALERTS A
                WHERE B.OFFENDER_BOOK_ID = A.OFFENDER_BOOK_ID
                AND A.ALERT_STATUS = 'ACTIVE')) AS ALERT_TYPES,
         B.LIVING_UNIT_ID,
         AIL.DESCRIPTION AS LIVING_UNIT_DESC,
         (SELECT *
          FROM (SELECT IMAGE_ID
                FROM IMAGES
                WHERE ACTIVE_FLAG = 'Y'
                AND IMAGE_OBJECT_TYPE = 'OFF_BKG'
                AND IMAGE_OBJECT_ID = B.OFFENDER_BOOK_ID
                AND IMAGE_VIEW_TYPE = 'FACE'
                AND ORIENTATION_TYPE = 'FRONT'
                ORDER BY CREATE_DATETIME DESC)
          WHERE ROWNUM <= 1) AS FACE_IMAGE_ID
  FROM OFFENDER_BOOKINGS B
    INNER JOIN OFFENDERS O ON B.OFFENDER_ID = O.OFFENDER_ID
    INNER JOIN CASELOAD_AGENCY_LOCATIONS C ON B.AGY_LOC_ID = C.AGY_LOC_ID AND C.CASELOAD_ID = :caseLoadId
    INNER JOIN STAFF_MEMBERS S ON B.ASSIGNED_STAFF_ID = S.STAFF_ID
    LEFT JOIN AGENCY_INTERNAL_LOCATIONS AIL ON B.LIVING_UNIT_ID = AIL.INTERNAL_LOCATION_ID
  WHERE B.ACTIVE_FLAG = 'Y'
  AND S.STAFF_ID = :staffId
}

FIND_PRISONERS {
SELECT
  O.OFFENDER_ID_DISPLAY AS NOMSID,
  O.FIRST_NAME,
  O.MIDDLE_NAME,
  O.LAST_NAME,
  O.BIRTH_DATE,
  RCE.DESCRIPTION AS ETHNICITY,
  RCS.DESCRIPTION AS SEX,
  O.BIRTH_COUNTRY_CODE
FROM OFFENDERS O
  LEFT JOIN REFERENCE_CODES RCE ON O.RACE_CODE = RCE.CODE
                                   AND RCE.DOMAIN = 'ETHNICITY'
  LEFT JOIN REFERENCE_CODES RCS ON O.SEX_CODE = RCS.CODE
                                   AND RCS.DOMAIN = 'SEX'
}
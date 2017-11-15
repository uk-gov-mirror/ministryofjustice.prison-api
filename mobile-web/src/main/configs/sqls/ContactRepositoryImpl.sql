FIND_NEXT_OF_KIN {
  SELECT P.LAST_NAME,
         P.FIRST_NAME,
         P.MIDDLE_NAME,
         O.CONTACT_TYPE,
         RC.DESCRIPTION AS CONTACT_DESCRIPTION,
         O.RELATIONSHIP_TYPE,
         RR.DESCRIPTION AS RELATIONSHIP_DESCRIPTION,
         O.EMERGENCY_CONTACT_FLAG
  FROM OFFENDER_CONTACT_PERSONS O 
    INNER JOIN PERSONS P ON P.PERSON_ID = O.PERSON_ID
    LEFT JOIN REFERENCE_CODES RC ON O.CONTACT_TYPE = RC.CODE and RC.DOMAIN = 'CONTACTS'
    LEFT JOIN REFERENCE_CODES RR ON O.RELATIONSHIP_TYPE = RR.CODE and RR.DOMAIN = 'RELATIONSHIP'
  WHERE O.OFFENDER_BOOK_ID = :bookingId
    AND O.NEXT_OF_KIN_FLAG = 'Y'
    AND O.ACTIVE_FLAG = 'Y'
  ORDER BY O.EMERGENCY_CONTACT_FLAG DESC, P.LAST_NAME ASC
}
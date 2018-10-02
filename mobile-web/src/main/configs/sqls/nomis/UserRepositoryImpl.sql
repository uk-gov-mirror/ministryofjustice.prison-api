FIND_USER_BY_USERNAME {
  SELECT SM.STAFF_ID,
    AUA.USERNAME,
    SM.FIRST_NAME,
    SM.LAST_NAME,
    AUA.WORKING_CASELOAD_ID AS ACTIVE_CASE_LOAD_ID,
    (   SELECT TAG_IMAGE_ID
        FROM TAG_IMAGES
        WHERE IMAGE_OBJECT_ID = SM.STAFF_ID
        AND IMAGE_OBJECT_TYPE = 'STAFF'
        AND ACTIVE_FLAG = 'Y'
    ) THUMBNAIL_ID
  FROM STAFF_MEMBERS SM JOIN STAFF_USER_ACCOUNTS AUA ON SM.STAFF_ID = AUA.STAFF_ID
                                                        AND AUA.USERNAME = :username
}

FIND_ROLES_BY_USERNAME {
  SELECT RL.ROLE_ID,
    CONCAT(CLR.CASELOAD_ID, CONCAT('_', REPLACE(RL.ROLE_CODE, '-', '_'))) ROLE_CODE,
    ROLE_NAME,
    PARENT_ROLE_CODE,
    CLR.CASELOAD_ID
  FROM USER_CASELOAD_ROLES CLR
    INNER JOIN OMS_ROLES RL ON RL.ROLE_ID = CLR.ROLE_ID
  WHERE USERNAME = :username
}

FIND_ACCESS_ROLES_BY_USERNAME_AND_CASELOAD {
  SELECT RL.ROLE_ID,
     RL.ROLE_CODE,
     ROLE_NAME,
     PARENT_ROLE_CODE,
     CLR.CASELOAD_ID
  FROM USER_CASELOAD_ROLES CLR
     INNER JOIN OMS_ROLES RL ON RL.ROLE_ID = CLR.ROLE_ID
  WHERE USERNAME = :username and CASELOAD_ID = :caseloadId
}

UPDATE_STAFF_ACTIVE_CASE_LOAD {
  UPDATE STAFF_USER_ACCOUNTS
  SET WORKING_CASELOAD_ID = :caseLoadId
  WHERE STAFF_ID = :staffId
}

FIND_USER_BY_STAFF_ID_STAFF_USER_TYPE {
  SELECT SM.STAFF_ID,
         AUA.USERNAME,
         SM.FIRST_NAME,
         SM.LAST_NAME,
         AUA.WORKING_CASELOAD_ID AS ACTIVE_CASE_LOAD_ID,
         (SELECT TAG_IMAGE_ID
          FROM TAG_IMAGES
          WHERE IMAGE_OBJECT_ID = SM.STAFF_ID
            AND IMAGE_OBJECT_TYPE = 'STAFF'
            AND ACTIVE_FLAG = 'Y') THUMBNAIL_ID
  FROM STAFF_MEMBERS SM
    INNER JOIN STAFF_USER_ACCOUNTS AUA ON SM.STAFF_ID = AUA.STAFF_ID
      AND AUA.STAFF_ID = :staffId
      AND AUA.STAFF_USER_TYPE = :staffUserType
}

  ROLE_ASSIGNED_COUNT {
    SELECT COUNT(*)
      FROM USER_CASELOAD_ROLES
     WHERE CASELOAD_ID = :caseloadId AND
           USERNAME = :username AND
           ROLE_ID = :roleId
  }

USER_ACCESSIBLE_CASELOAD_COUNT {
  SELECT COUNT(*) FROM USER_ACCESSIBLE_CASELOADS WHERE CASELOAD_ID = :caseloadId AND USERNAME = :username
}

FIND_ACTIVE_STAFF_USERS_WITH_ACCESSIBLE_CASELOAD {
  SELECT SM.STAFF_ID,
    SUA.USERNAME,
    SM.FIRST_NAME,
    SM.LAST_NAME,
    SUA.WORKING_CASELOAD_ID AS ACTIVE_CASE_LOAD_ID
  FROM USER_ACCESSIBLE_CASELOADS UAC
    INNER JOIN STAFF_USER_ACCOUNTS SUA ON SUA.USERNAME = UAC.USERNAME
    INNER JOIN STAFF_MEMBERS SM ON SUA.STAFF_ID = SM.STAFF_ID
  WHERE UAC.CASELOAD_ID = :caseloadId
        AND SM.STATUS = 'ACTIVE'
}

USER_ACCESSIBLE_CASELOAD_INSERT {
   INSERT INTO USER_ACCESSIBLE_CASELOADS (CASELOAD_ID, USERNAME, START_DATE) VALUES (:caseloadId, :username, :startDate)
}

FIND_ROLES_BY_CASELOAD_AND_ROLE {
  SELECT RL.ROLE_ID,
    REPLACE(RL.ROLE_CODE, '-', '_') ROLE_CODE,
    ROLE_NAME,
    REPLACE(RL.PARENT_ROLE_CODE, '-', '_') PARENT_ROLE_CODE,
    CLR.CASELOAD_ID,
    CLR.USERNAME,
    AUA.STAFF_ID
  FROM USER_CASELOAD_ROLES CLR
    INNER JOIN OMS_ROLES RL ON RL.ROLE_ID = CLR.ROLE_ID
    INNER JOIN STAFF_USER_ACCOUNTS AUA ON AUA.USERNAME = CLR.USERNAME
  WHERE RL.ROLE_CODE = :roleCode
  AND   CLR.CASELOAD_ID = :caseloadId
}

GET_ROLE_ID_FOR_ROLE_CODE {
  select ROLE_ID from OMS_ROLES WHERE ROLE_CODE = :roleCode
}

INSERT_USER_ROLE {
   INSERT INTO USER_CASELOAD_ROLES (ROLE_ID, CASELOAD_ID, USERNAME)
   VALUES (
     :roleId, :caseloadId, :username)
}

DELETE_USER_ROLE {
   DELETE FROM USER_CASELOAD_ROLES WHERE CASELOAD_ID = :caseloadId AND USERNAME = :username AND ROLE_ID = :roleId
}

FIND_USERS_BY_CASELOAD {
SELECT SM.STAFF_ID,
  SUA.USERNAME,
  SM.FIRST_NAME,
  SM.LAST_NAME
FROM STAFF_USER_ACCOUNTS SUA
  INNER JOIN STAFF_MEMBERS SM ON SUA.STAFF_ID = SM.STAFF_ID
  INNER JOIN USER_ACCESSIBLE_CASELOADS UAC ON SUA.USERNAME = UAC.USERNAME

WHERE UAC.CASELOAD_ID = :caseloadId
}

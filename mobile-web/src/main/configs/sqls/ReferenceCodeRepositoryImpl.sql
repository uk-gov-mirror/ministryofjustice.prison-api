FIND_REFERENCE_CODES_BY_DOMAIN {
  SELECT CODE,
         DOMAIN,
         DESCRIPTION,
         PARENT_DOMAIN PARENT_DOMAIN_ID,
         PARENT_CODE,
         ACTIVE_FLAG
	FROM REFERENCE_CODES
	WHERE DOMAIN = :domain
}

FIND_REFERENCE_CODES_BY_DOMAIN_PLUS_SUBTYPES {
	SELECT RC.CODE,
	       RC.DOMAIN,
	       RC.DESCRIPTION,
	       RC.PARENT_DOMAIN PARENT_DOMAIN_ID,
	       RC.PARENT_CODE,
	       RC.ACTIVE_FLAG,
	       RCSUB.CODE SUB_CODE,
	       RCSUB.DOMAIN SUB_DOMAIN,
	       RCSUB.DESCRIPTION SUB_DESCRIPTION,
	       RCSUB.ACTIVE_FLAG SUB_ACTIVE_FLAG
	FROM REFERENCE_CODES RC
	  LEFT JOIN REFERENCE_CODES RCSUB ON RCSUB.PARENT_CODE = RC.CODE AND RCSUB.PARENT_DOMAIN = RC.DOMAIN
	WHERE RC.DOMAIN = :domain
	ORDER BY RC.CODE, RCSUB.CODE
}

FIND_REFERENCE_CODES_BY_DOMAIN_PARENT {
	SELECT CODE,
	       DOMAIN,
	       DESCRIPTION,
	       PARENT_DOMAIN PARENT_DOMAIN_ID,
	       PARENT_CODE,
	       ACTIVE_FLAG
	FROM REFERENCE_CODES
	WHERE DOMAIN = :domain
	  AND PARENT_CODE = :parentCode
}

FIND_REFERENCE_CODE_BY_DOMAIN_CODE {
  SELECT CODE,
         DOMAIN,
         DESCRIPTION,
         PARENT_DOMAIN PARENT_DOMAIN_ID,
         PARENT_CODE,
         ACTIVE_FLAG
	FROM REFERENCE_CODES
	WHERE DOMAIN = :domain
	  AND CODE = :code
}

FIND_REFERENCE_CODE_BY_DOMAIN_PARENT_CODE {
  SELECT CODE,
         DOMAIN,
         DESCRIPTION,
         PARENT_DOMAIN PARENT_DOMAIN_ID,
         PARENT_CODE,
         ACTIVE_FLAG
	FROM REFERENCE_CODES
	WHERE DOMAIN = :domain
	  AND PARENT_CODE = :parentCode
	  AND CODE = :code
}

FIND_CNOTE_TYPES_AND_SUBTYPES_BY_CASELOAD {
	SELECT DISTINCT RC.DESCRIPTION,
	        W.WORK_TYPE CODE,
		      RC.DOMAIN,
		      RC.PARENT_DOMAIN PARENT_DOMAIN_ID,
		      RC.PARENT_CODE,
		      W.ACTIVE_FLAG,
		      RCSUB.DOMAIN SUB_DOMAIN,
		      WSUB.WORK_SUB_TYPE SUB_CODE,
		      RCSUB.DESCRIPTION SUB_DESCRIPTION,
		      WSUB.ACTIVE_FLAG SUB_ACTIVE_FLAG
	FROM WORKS W
	  INNER JOIN REFERENCE_CODES RC ON RC.CODE = W.WORK_TYPE
	  LEFT JOIN REFERENCE_CODES RCSUB ON RCSUB.DOMAIN = 'TASK_SUBTYPE'
	  INNER JOIN WORKS WSUB ON RCSUB.CODE = WSUB.WORK_SUB_TYPE
		  AND WSUB.WORKFLOW_TYPE = 'CNOTE'
			AND WSUB.WORK_TYPE = W.WORK_TYPE
			AND WSUB.MANUAL_SELECT_FLAG ='Y'
			AND WSUB.ACTIVE_FLAG  = 'Y'
	WHERE W.WORKFLOW_TYPE = 'CNOTE'
	  AND RC.DOMAIN = 'TASK_TYPE'
		AND W.CASELOAD_TYPE IN ( (:caseLoadType), 'BOTH')
		AND W.MANUAL_SELECT_FLAG ='Y'
		AND W.ACTIVE_FLAG  = 'Y'
		AND RC.CODE <> 'WR'
	ORDER BY W.WORK_TYPE, WSUB.WORK_SUB_TYPE
}

FIND_CNOTE_TYPES_BY_CASELOAD {
	SELECT DISTINCT RC.DESCRIPTION,
					WORK_TYPE CODE,
					RC.DOMAIN,
					RC.PARENT_DOMAIN PARENT_DOMAIN_ID,
					RC.PARENT_CODE,
					RC.ACTIVE_FLAG
	FROM WORKS W JOIN REFERENCE_CODES RC ON RC.CODE = W.WORK_TYPE
	WHERE WORKFLOW_TYPE = 'CNOTE'
	AND RC.DOMAIN = 'TASK_TYPE'
	AND W.CASELOAD_TYPE IN ( (:caseLoadType), 'BOTH')
	AND W.MANUAL_SELECT_FLAG ='Y'
	AND W.ACTIVE_FLAG  = 'Y'
	AND RC.CODE  <> 'WR'
}

FIND_CNOTE_SUB_TYPES_BY_CASE_NOTE_TYPE {
	SELECT RC.DESCRIPTION,
			W.WORK_SUB_TYPE CODE,
			RC.DOMAIN,
			RC.PARENT_DOMAIN PARENT_DOMAIN_ID,
			RC.PARENT_CODE,
			RC.ACTIVE_FLAG
	FROM WORKS W JOIN REFERENCE_CODES RC ON RC.CODE = W.WORK_SUB_TYPE
 	WHERE WORKFLOW_TYPE = 'CNOTE'
	AND RC.DOMAIN = 'TASK_SUBTYPE'
	AND W.WORK_TYPE = :caseNoteType
	AND W.MANUAL_SELECT_FLAG ='Y'
	AND W.ACTIVE_FLAG  = 'Y'
}

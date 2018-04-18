
CREATE OR REPLACE TRIGGER "OFFENDER_PROGRAM_PROFILES_TA"
BEFORE INSERT OR UPDATE OR DELETE ON OFFENDER_PROGRAM_PROFILES
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
  DECLARE
    l_scn NUMBER;
    l_tid VARCHAR2(32);
  BEGIN
    /*
    ============================================================
       Generated by 2.3  Date Generation 10-NOV-2008
    ============================================================
      MODIFICATION HISTORY
       Person       Date      version      Comments
    -----------  --------- -----------  -------------------------------
        GJC      05/03/2007  2.3          Allow application setting some columns
        GJC      23/10/2006  2.2          Audit DELETE statements
       David Ng  18/04/2006  2.0.1        Audit column trigger
    */
    IF INSERTING
    THEN
      :NEW.create_datetime := NVL(:NEW.create_datetime, systimestamp);
      :NEW.create_user_id := NVL(:NEW.create_user_id, user);
    ELSIF UPDATING
      THEN
        :NEW.modify_datetime := systimestamp;
        :NEW.modify_user_id := user;
    END IF;
    IF NOT DELETING
    THEN
      :NEW.Audit_timestamp := systimestamp;
      :NEW.Audit_User_ID := SYS_CONTEXT('NOMIS', 'AUDIT_USER_ID', 30);
      :NEW.Audit_Module_Name := SYS_CONTEXT('NOMIS', 'AUDIT_MODULE_NAME', 65);
      :NEW.Audit_Client_User_ID := SYS_CONTEXT('NOMIS', 'AUDIT_CLIENT_USER_ID', 64);
      :NEW.Audit_Client_IP_Address := SYS_CONTEXT('NOMIS', 'AUDIT_CLIENT_IP_ADDRESS', 39);
      :NEW.Audit_Client_Workstation_Name := SYS_CONTEXT('NOMIS', 'AUDIT_CLIENT_WORKSTATION_NAME', 64);
      :NEW.Audit_Additional_Info := SYS_CONTEXT('NOMIS', 'AUDIT_ADDITIONAL_INFO', 256);
    ELSE
      l_tid := DBMS_TRANSACTION.local_transaction_id(create_transaction=>FALSE);
      SELECT current_scn
      INTO l_scn
      FROM v$database;
      INSERT INTO OMS_DELETED_ROWS
      (
        table_name,
        xid,
        scn,
        audit_timestamp,
        audit_user_id,
        audit_module_name,
        audit_client_user_id,
        audit_client_ip_address,
        audit_client_workstation_name,
        audit_additional_info
      )
      VALUES
        (
          'OFFENDER_PROGRAM_PROFILES',
          converttoxid(l_tid),
          l_scn,
          systimestamp,
          SYS_CONTEXT('NOMIS', 'AUDIT_USER_ID', 30),
          SYS_CONTEXT('NOMIS', 'AUDIT_MODULE_NAME', 65),
          SYS_CONTEXT('NOMIS', 'AUDIT_CLIENT_USER_ID', 64),
          SYS_CONTEXT('NOMIS', 'AUDIT_CLIENT_IP_ADDRESS', 39),
          SYS_CONTEXT('NOMIS', 'AUDIT_CLIENT_WORKSTATION_NAME', 64),
          SYS_CONTEXT('NOMIS', 'AUDIT_ADDITIONAL_INFO', 256)
        );
    END IF;
  END;

/



CREATE OR REPLACE TRIGGER "OFFENDER_PROGRAM_PROFILES_TR"
BEFORE
INSERT OR UPDATE
  ON OFFENDER_PROGRAM_PROFILES
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
  DECLARE V_numrows INTEGER;
  BEGIN
    -- Lines added by GJC 21/12/2007 to check if the trigger code should be executed or not
    IF SYS_CONTEXT('NOMIS', 'AUDIT_MODULE_NAME', 50) = 'MERGE'
    THEN
      RETURN;
    END IF;
    -- Change added by GJC 21/12/2007 to check if the trigger code should be executed or not
    /* =========================================================
       Version Number = 2.2  Date Modified = 21-DEC-2007
       ========================================================= */

    /* MODIFICATION HISTORY
       Person      Date            Version       Comments
       ---------   ------       ------------  ------------------------------
       Graham      21/12/2007      2.2           #7775: Code added for Merge, fix versioning
       David Ng    08/08/2006      2.1           remove constraint on the start date
       David Ng    06/03/2006      2.0           Check reference codes
    */
    IF :NEW.Offender_Program_Status IS NOT NULL
    THEN
      SELECT count(*)
      INTO v_numrows
      FROM Reference_codes
      WHERE code = :new.Offender_Program_status
            AND DOMAIN = ('OFF_PRG_STS');
      IF (v_Numrows = 0)
      THEN
        tag_error.raise_app_error(-20005, 'Invalid Offender Program Status ');
      END IF;
      --        IF (:NEW.Offender_Program_Status = 'ALLOC') AND
      --           (:NEW.OFFENDER_START_DATE IS NULL)   THEN
      --            tag_error.raise_app_error(-20005, 'No Start Date for allocated programme ')  ;
      --        END IF ;
      IF (:NEW.Offender_Program_Status = 'END') AND
         (:NEW.OFFENDER_END_DATE IS NULL)
      THEN
        tag_error.raise_app_error(-20005, 'No End Date for Ended programme ');
      END IF;
    END IF;
    IF :NEW.Waitlist_Decision_code IS NOT NULL
    THEN
      SELECT count(*)
      INTO v_numrows
      FROM Reference_codes
      WHERE code = :new.Waitlist_Decision_code
            AND DOMAIN = ('PS_ACT_DEC');
      IF (v_Numrows = 0)
      THEN
        tag_error.raise_app_error(-20005, 'Invalid decision code ');
      END IF;
    END IF;
    IF :NEW.Crs_acty_ID IS NOT NULL
    THEN
      SELECT count(*)
      INTO v_numrows
      FROM course_activities
      WHERE crs_acty_ID = :new.crs_acty_ID
            AND course_activity_Type IS NOT NULL;
      IF (v_Numrows = 0)
      THEN
        tag_error.raise_app_error(-20005, 'Course without course Activity type defined ');
      END IF;
    END IF;
  END;

/



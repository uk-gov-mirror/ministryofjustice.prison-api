
CREATE OR REPLACE TRIGGER "OFFENDER_CASES_T2"
AFTER
INSERT OR UPDATE OF case_info_number
  ON offender_cases
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
  DECLARE
    v_exist VARCHAR2(1) := NULL;

    CURSOR case_identifier_exist
    IS
      SELECT 'X'
      FROM offender_case_identifiers
      WHERE case_id = :NEW.case_id
            AND identifier_type = :NEW.case_info_prefix
            AND identifier_no = :NEW.case_info_number;
  BEGIN
    -- Lines added by GJC 21/12/2007 to check if the trigger code should be executed or not
    IF SYS_CONTEXT('NOMIS', 'AUDIT_MODULE_NAME', 50) = 'MERGE'
    THEN
      RETURN;
    END IF;
    -- Change added by GJC 21/12/2007 to check if the trigger code should be executed or not
    /*
    ============================================================
      Version Number = 2.8  Date Modified = 21-DEC-2007
    ============================================================
      MODIFICATION HISTORY
      Person     Date        Version        Comments
      Graham     21/12/2007      2.8        #7775: Code added for Merge, fix versioning
      Claus      30/05/2006      2.7        D# 2140. Re-fix
      Claus      30/05/2006      2.6        Synchronised version number
      Claus      30/05/2006      2.4        D# 2140. Corrected cursor case_identifier_exist.
      Claus      19/05/2006      2.3        D# 1084. Default 'CASE/INFO#' if prefix is null.
      Claus      19/05/2006      2.2        D# 1084. Only insert/update if both prefix and case id populated.
      Claus      15/05/2006      2.1        D# 1084. Include case info prefix.
      Surya      20/12/2005      2.0        Initial Draft.
    */
    IF INSERTING
    THEN
      IF :NEW.case_info_number IS NOT NULL
      THEN
        tag_legal_cases.case_identifiers_insert
        (:NEW.case_id,
         NVL(:NEW.case_info_prefix,
             'CASE/INFO#'),
         :NEW.case_info_number);
      END IF;
    ELSIF UPDATING
      THEN
        IF :NEW.case_info_number IS NOT NULL
        THEN
          OPEN case_identifier_exist;

          FETCH case_identifier_exist
          INTO v_exist;

          IF case_identifier_exist%NOTFOUND
          THEN
            CLOSE case_identifier_exist;

            tag_legal_cases.case_identifiers_insert
            (:NEW.case_id,
             NVL(:NEW.case_info_prefix,
                 'CASE/INFO#'),
             :NEW.case_info_number);
          ELSE
            CLOSE case_identifier_exist;
          END IF;
        END IF;
    END IF;
    EXCEPTION
    WHEN OTHERS
    THEN
    tag_error.handle;
  END;

/



CREATE OR REPLACE TRIGGER "OFFENDER_CASES_T1"
AFTER
UPDATE OF case_info_number
  ON offender_cases
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
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
       Graham      21/12/2007          2.2   #7775: Code added for Merge, fix versioning
       Patrick     12/04/2001                Build
    */
    -- The purpose of this trigger is to create a link between Community and the Financial systems.
    -- It auto updates the value of CASE_ID in OFFENDER_DEDUCTIONS and OFFENDER_PAYMENT_PLANS when the CASE_ID in
    -- OFFENDER_CASES is changed to a new value.  There is a system_profile to turn this logic on and off.
    DECLARE
      CURSOR profile_oblig IS
        SELECT PROFILE_VALUE
        FROM SYSTEM_PROFILES
        WHERE PROFILE_TYPE = 'CLIENT'
              AND PROFILE_CODE = 'CASE_OBLIGN';
      case_integrate_flag SYSTEM_PROFILES.PROFILE_VALUE%TYPE := 'N';
    BEGIN
      OPEN profile_oblig;
      FETCH profile_oblig INTO case_integrate_flag;
      CLOSE profile_oblig;
      IF case_integrate_flag = 'Y'
      THEN
        UPDATE OFFENDER_DEDUCTIONS
        SET INFORMATION_NUMBER = :NEW.CASE_INFO_NUMBER
        WHERE CASE_ID = :OLD.CASE_ID;
        UPDATE OFFENDER_PAYMENT_PLANS
        SET INFORMATION_NUMBER = :NEW.CASE_INFO_NUMBER
        WHERE CASE_ID = :OLD.CASE_ID;
      END IF;
    END;
  END;

/



CREATE OR REPLACE TRIGGER "OFFENDER_CASES_TA"
BEFORE INSERT OR UPDATE OR DELETE ON OFFENDER_CASES
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
          'OFFENDER_CASES',
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



CREATE OR REPLACE TRIGGER "OFFENDER_CASES_T4"
BEFORE INSERT
  ON offender_cases
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
  BEGIN
    -- Lines added by GJC 21/12/2007 to check if the trigger code should be executed or not
    IF SYS_CONTEXT('NOMIS', 'AUDIT_MODULE_NAME', 50) = 'MERGE'
    THEN
      RETURN;
    END IF;
    -- Change added by GJC 21/12/2007 to check if the trigger code should be executed or not
    /*
       ============================================================
       Version Number = 2.3  Date Modified = 09-MAY-2008
       ============================================================
       MODIFICATION HISTORY
       Person       Date        Version      Comments
       -----------  ---------   -----------  -------------------------------
      Laurence     09/05/2008      2.3      Removed check from context when
                                             populating lids_case_number.  Now only
                                             does it if this value is null and hence
                                             is not being passed in from migration.
       Graham       21/12/2007      2.2      #7775: Code added for Merge, fix versioning
       Surya        31/05/2006	2.1      Added the sys context as it should be
                                             populated from Application, Interface but
                         not from data migration.
       Surya        29/05/2006      2.0      Initial Draft - Lids case number
                                             increments for the case with in
                                          the current booking.
       */
    IF :new.lids_case_number IS NULL
    THEN
      SELECT NVL(MAX(lids_case_number), 0) + 1
      INTO :NEW.lids_case_number
      FROM offender_cases
      WHERE offender_book_id = :NEW.offender_book_id;
    END IF;
    EXCEPTION
    WHEN OTHERS
    THEN
    tag_error.handle;
  END offender_cases_t4;

/



CREATE OR REPLACE TRIGGER "OFFENDER_CASES_T3"
AFTER UPDATE OF status_update_reason
  ON offender_cases
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
  BEGIN
    -- Lines added by GJC 21/12/2007 to check if the trigger code should be executed or not
    IF SYS_CONTEXT('NOMIS', 'AUDIT_MODULE_NAME', 50) = 'MERGE'
    THEN
      RETURN;
    END IF;

    -- Change added by GJC 21/12/2007 to check if the trigger code should be executed or not
    /*
       ============================================================
         Version Number = 2.7  Date Modified = 31-JAN-2009
        ============================================================
         MODIFICATION HISTORY
         Person       Date      Version      Comments
         Ragini       15/01/2009  2.7         D 13255: Removed the NVL clause from :OLD.status_update_comment
         Claus        31/10/2008  2.6        D# 11526. Removed IF-condition as must always audit change.
         Claus        12/06/2008  2.5        D# 9215. Peer-review fix.
         Claus        11/06/2008  2.4        D# 9215. Re-fix.
         Claus        04/06/2008  2.3        D# 9215. Added NVL to :OLD.status_update_reason.
         Graham       21/12/2007  2.2        #7775: Code added for Merge, fix versioning
         Surya        23/04/2006  2.1        Modified as earlier one was giving oracle errors
                                             on initial entry.
         Claus        19/04/2006  2.0        Created.
       */
    INSERT INTO offender_case_statuses
    (case_id,
     status_update_reason,
     status_update_comment,
     status_update_date,
     status_update_staff_id,
     offender_case_status_id
    )
    VALUES (:OLD.case_id,
            NVL(:OLD.status_update_reason, :NEW.status_update_reason),
            :OLD.status_update_comment,
            NVL(:OLD.status_update_date, :NEW.status_update_date),
            NVL(:OLD.status_update_staff_id, :NEW.status_update_staff_id),
            offender_case_status_id.NEXTVAL
    );
  END;

/



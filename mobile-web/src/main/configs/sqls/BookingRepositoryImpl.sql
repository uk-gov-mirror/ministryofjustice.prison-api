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
     FROM OFFENDER_SENTENCE_ADJUSTS OSA
     WHERE OSA.SENTENCE_ADJUST_CODE = 'ADA'
     AND OSA.OFFENDER_BOOK_ID = OB.OFFENDER_BOOK_ID
     GROUP BY OSA.OFFENDER_BOOK_ID) AS ADDITIONAL_DAYS_AWARDED
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
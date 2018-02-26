@global
Feature: Booking Sentence Details

  Acceptence Criteria
  A logged on staff user can retrieve sentence details for an offender booking.
  The earliest sentence start date is used when an offender booking has multiple imprisonment sentence terms.
  The latest sentence date calculation record is used when an offender booking has multiple calculation records.
  From the latest sentence date calculation record:
    - if present, the sentence expiry date is the overridden SED value, otherwise it is the calculated SED value.
    - if present, the late term date is the overridden LTD value, otherwise it is the calculated LTD value.
    - if present, the mid term date is the overridden MTD value, otherwise it is the calculated MTD value.
    - if present, the early term date is the overridden ETD value, otherwise it is the calculated ETD value.
    - if present, the automatic release date is the overridden ARD value, otherwise it is the calculated ARD value.
    - if present, the conditional release date is the overridden CRD value, otherwise it is the calculated CRD value.
    - if present, the non-parole date is the overridden NPD value, otherwise it is the calculated NPD value.
    - if present, the post-recall release date is the overridden PRRD value, otherwise it is the calculated PRRD value.
    - if present, the home detention curfew eligibility date is the overridden HDCED value, otherwise it is the calculated HDCED value.
    - if present, the parole eligibility date is the overridden PED value, otherwise it is the calculated PED value.
    - if present, the home detention curfew actual date is the overridden HDCAD value (the calculated HDCAD value is not used).
    - if present, the actual parole date is the overridden APD value (the calculated APD value is not used).
    - if present, the licence expiry date is the overridden LED value, otherwise it is the calculated LED value.
    - if present, the tariff date is the overriden tariff date value, otherwise it is the calculated tariff date value.
    - for NOMIS only, the release on temporary licence date value is the override ROTL value (there is no calculated ROTL value).
    - for NOMIS only, the early removal scheme eligibility date value is the override ERSED value (there is no calculated ERSED value).
    - for NOMIS only, the topup supervision expiry date value is the override TUSED value, otherwise it is the calculated TUSED value.
    - the release date for a non-DTO sentence type is derived from one or more of ARD, CRD, NPD and/or PRRD as follows:
      - if more than one ARD, CRD, NPD and/or PRRD value is present (calculated or overridden), the latest date is the release date
  Additional days awarded is the sum of all active sentence adjustment records for an offender booking with the 'ADA' adjustment type.

  Background:
    Given a user has authenticated with the API

  Scenario: Sentence details are requested for booking that does not exist
    When sentence details are requested for an offender with booking id "-99"
    Then resource not found response is received from sentence details API

  Scenario: Sentence details are requested for booking that is not part of any of logged on staff user's caseloads
    When sentence details are requested for an offender with booking id "-16"
    Then resource not found response is received from sentence details API

  Scenario Outline: Retrieve sentence details for an offender, check non-DTO sentence details only
    When sentence details are requested for an offender with booking id "<bookingId>"
    Then sentence start date matches "<ssd>"
    And automatic release date matches "<ard>"
    And override automatic release date matches "<ardOverride>"
    And conditional release date matches "<crd>"
    And override conditional release date matches "<crdOverride>"
    And non-parole date matches "<npd>"
    And override non-parole date matches "<npdOverride>"
    And post-recall release date matches "<prrd>"
    And override post-recall release date matches "<prrdOverride>"
    And non-DTO release date matches "<nonDtoReleaseDate>"
    And non-DTO release date type matches "<nonDtoReleaseDateType>"

    Examples:
      | bookingId | ssd        | ard        | ardOverride | crd        | crdOverride | npd        | npdOverride | prrd       | prrdOverride | nonDtoReleaseDate | nonDtoReleaseDateType |
      | -1        | 2017-03-25 |            |             | 2019-03-24 |             |            |             |            |              | 2019-03-24        | CRD                   |
      | -2        | 2016-11-22 | 2018-05-21 | 2018-04-21  |            |             |            |             |            |              | 2018-04-21        | ARD                   |
      | -3        | 2015-03-16 |            |             |            |             |            |             |            |              |                   |                       |
      | -4        | 2007-10-16 | 2021-05-06 |             |            |             |            |             | 2021-08-29 | 2021-08-31   | 2021-08-31        | PRRD                  |
      | -5        | 2017-02-08 |            |             | 2023-02-07 |             | 2022-02-15 | 2022-02-02  |            |              | 2023-02-07        | CRD                   |
      | -6        | 2017-09-01 | 2018-02-28 |             | 2018-01-31 |             |            |             |            |              | 2018-02-28        | ARD                   |
      | -7        | 2017-09-01 | 2018-02-28 |             |            |             | 2017-12-31 |             |            |              | 2018-02-28        | ARD                   |
      | -8        | 2017-09-01 | 2018-02-28 |             |            |             |            |             | 2018-03-31 |              | 2018-03-31        | PRRD                  |
      | -9        | 2017-09-01 |            |             | 2018-01-31 |             | 2017-12-31 |             |            |              | 2018-01-31        | CRD                   |
      | -10       | 2017-09-01 |            |             | 2018-01-31 |             |            |             | 2018-03-31 |              | 2018-03-31        | PRRD                  |
      | -11       | 2017-09-01 |            |             |            |             | 2017-12-31 |             | 2018-03-31 |              | 2018-03-31        | PRRD                  |
      | -12       | 2017-09-01 |            |             |            |             |            |             | 2018-03-31 |              | 2018-03-31        | PRRD                  |
      | -17       | 2015-05-05 |            |             |            |             |            |             |            |              |                   |                       |
      | -18       | 2016-11-17 |            |             |            |             |            |             |            |              |                   |                       |
      | -24       | 2017-07-07 |            |             |            |             |            |             |            |              |                   |                       |
      | -25       | 2009-09-09 |            |             |            |             |            |             |            |              |                   |                       |
      | -29       | 2017-02-08 |            |             |            |             | 2017-12-31 |             |            |              | 2017-12-31        | NPD                   |
      | -30       | 2007-10-16 |            |             |            |             |            |             |            |              |                   |                       |
      | -32       |            |            |             |            |             |            |             |            |              |                   |                       |

  Scenario Outline: Retrieve sentence details for an offender, check DTO sentence details
    When sentence details are requested for an offender with booking id "<bookingId>"
    Then sentence start date matches "<ssd>"
    And sentence expiry date matches "<sed>"
    And additional days awarded matches "<ada>"
    And early term date matches "<etd>"
    And mid term date matches "<mtd>"
    And late term date matches "<ltd>"

    Examples:
      | bookingId | ssd        | sed        | ada | etd        | mtd        | ltd        |
      | -1        | 2017-03-25 | 2020-03-24 | 12  |            |            |            |
      | -2        | 2016-11-22 | 2019-05-21 |     |            |            |            |
      | -3        | 2015-03-16 | 2020-03-15 |     | 2017-09-15 | 2018-03-15 | 2018-09-15 |
      | -4        | 2007-10-16 | 2022-10-20 | 5   |            |            |            |
      | -5        | 2017-02-08 | 2023-08-07 | 14  | 2023-02-07 | 2023-05-07 | 2023-08-07 |
      | -6        | 2017-09-01 | 2018-05-31 | 17  |            |            |            |
      | -7        | 2017-09-01 | 2018-05-31 |     | 2017-11-30 | 2017-12-31 | 2018-01-31 |
      | -8        | 2017-09-01 | 2018-05-31 |     | 2017-11-30 | 2017-12-31 | 2018-01-31 |
      | -9        | 2017-09-01 | 2018-05-31 |     | 2017-11-30 | 2017-12-31 | 2018-01-31 |
      | -10       | 2017-09-01 | 2018-05-31 |     |            |            |            |
      | -11       | 2017-09-01 | 2018-05-31 |     |            |            |            |
      | -12       | 2017-09-01 | 2018-05-31 |     |            |            |            |
      | -17       | 2015-05-05 |            |     |            |            |            |
      | -18       | 2016-11-17 |            |     |            |            |            |
      | -24       | 2017-07-07 |            |     |            |            |            |
      | -25       | 2009-09-09 |            |     | 2023-09-08 | 2024-09-08 | 2025-09-08 |
      | -29       | 2017-02-08 | 2023-08-07 |     |            |            |            |
      | -30       | 2007-10-16 | 2022-10-20 |     | 2021-02-28 | 2021-03-25 | 2021-04-28 |
      | -32       |            |            |     |            |            |            |

  Scenario Outline: Retrieve sentence details for an offender, check other dates
    When sentence details are requested for an offender with booking id "<bookingId>"
    Then sentence start date matches "<ssd>"
    And home detention curfew eligibility date matches "<hdced>"
    And parole eligibility date matches "<ped>"
    And licence expiry date matches "<led>"
    And home detention curfew actual date matches "<hdcad>"
    And actual parole date matches "<apd>"
    And confirmed release date matches "<confRelDate>"
    And release date matches "<releaseDate>"
    And tariff date matches "<tariffDate>"

    Examples:
      | bookingId | ssd        | hdced      | ped        | led        | hdcad      | apd        | confRelDate | releaseDate | tariffDate |
      | -1        | 2017-03-25 |            |            |            |            | 2018-09-27 | 2018-04-23  | 2018-04-23  |            |
      | -2        | 2016-11-22 |            |            |            |            |            | 2018-04-19  | 2018-04-19  |            |
      | -3        | 2015-03-16 |            |            |            |            |            |             | 2018-03-15  |            |
      | -4        | 2007-10-16 |            |            |            |            |            |             | 2021-08-31  |            |
      | -5        | 2017-02-08 | 2019-06-02 | 2019-06-01 |            |            |            |             | 2023-05-07  |            |
      | -6        | 2017-09-01 |            |            |            | 2018-05-15 |            |             | 2018-05-15  |            |
      | -7        | 2017-09-01 |            |            |            |            |            | 2018-01-05  | 2018-01-05  |            |
      | -8        | 2017-09-01 |            |            |            |            | 2017-12-23 |             | 2017-12-23  |            |
      | -9        | 2017-09-01 |            |            |            | 2018-01-15 |            | 2018-01-13  | 2018-01-13  |            |
      | -10       | 2017-09-01 |            |            |            |            | 2018-02-22 |             | 2018-02-22  |            |
      | -11       | 2017-09-01 |            |            |            |            |            |             | 2018-03-31  |            |
      | -12       | 2017-09-01 |            |            |            |            |            |             | 2018-03-31  |            |
      | -17       | 2015-05-05 |            |            |            |            |            | 2018-01-16  | 2018-01-16  |            |
      | -18       | 2016-11-17 |            |            |            | 2019-09-19 |            |             | 2019-09-19  |            |
      | -24       | 2017-07-07 |            |            |            |            | 2022-06-06 | 2022-02-02  | 2022-02-02  |            |
      | -25       | 2009-09-09 |            |            |            |            | 2019-09-08 | 2023-03-03  | 2023-03-03  |            |
      | -27       | 2014-09-09 |            |            |            |            |            |             |             | 2029-09-08 |
      | -28       | 2014-09-09 |            |            |            |            |            |             |             | 2031-03-08 |
      | -29       | 2017-02-08 |            | 2021-05-05 | 2020-08-07 |            |            |             | 2017-12-31  |            |
      | -30       | 2007-10-16 | 2020-12-30 |            | 2021-09-24 |            | 2021-01-02 |             | 2021-01-02  |            |
      | -32       |            |            |            |            |            |            |             |             |            |

  @nomis
  Scenario Outline: Retrieve sentence details for an offender, check other dates - NOMIS only - for ROTL, ERSED and TUSED
    When sentence details are requested for an offender with booking id "<bookingId>"
    Then sentence start date matches "<ssd>"
    And release on temporary licence date matches "<rotl>"
    And early removal scheme eligibility date matches "<ersed>"
    And topup supervision expiry date matches "<tused>"

    Examples:
      | bookingId | ssd        | rotl       | ersed      | tused      |
      | -1        | 2017-03-25 |            |            |            |
      | -2        | 2016-11-22 | 2018-02-25 |            |            |
      | -3        | 2015-03-16 |            |            |            |
      | -4        | 2007-10-16 |            | 2019-09-01 |            |
      | -5        | 2017-02-08 |            |            |            |
      | -6        | 2017-09-01 |            |            | 2021-03-30 |
      | -7        | 2017-09-01 |            |            | 2021-03-31 |
      | -8        | 2017-09-01 |            |            |            |
      | -9        | 2017-09-01 |            |            |            |
      | -10       | 2017-09-01 |            |            |            |
      | -11       | 2017-09-01 |            |            |            |
      | -12       | 2017-09-01 |            |            |            |
      | -17       | 2015-05-05 |            |            |            |
      | -18       | 2016-11-17 |            |            |            |
      | -24       | 2017-07-07 |            |            |            |
      | -25       | 2009-09-09 |            |            |            |
      | -29       | 2017-02-08 |            |            |            |
      | -30       | 2007-10-16 |            |            |            |
      | -32       |            |            |            |            |

  Scenario Outline: Retrieve sentence details as a list and filter by booking id and check data matches
    When sentence details are requested for an offenders in logged in users caseloads with booking id "<bookingId>"
    Then sentence start date matches "<ssd>"
    And home detention curfew eligibility date matches "<hdced>"
    And parole eligibility date matches "<ped>"
    And licence expiry date matches "<led>"
    And home detention curfew actual date matches "<hdcad>"
    And actual parole date matches "<apd>"
    And confirmed release date matches "<confRelDate>"
    And release date matches "<releaseDate>"
    And tariff date matches "<tariffDate>"

    Examples:
      | bookingId | ssd        | hdced      | ped        | led        | hdcad      | apd        | confRelDate | releaseDate | tariffDate |
      | -1        | 2017-03-25 |            |            |            |            | 2018-09-27 | 2018-04-23  | 2018-04-23  |            |
      | -2        | 2016-11-22 |            |            |            |            |            | 2018-04-19  | 2018-04-19  |            |
      | -3        | 2015-03-16 |            |            |            |            |            |             | 2018-03-15  |            |
      | -4        | 2007-10-16 |            |            |            |            |            |             | 2021-08-31  |            |
      | -5        | 2017-02-08 | 2019-06-02 | 2019-06-01 |            |            |            |             | 2023-05-07  |            |
      | -6        | 2017-09-01 |            |            |            | 2018-05-15 |            |             | 2018-05-15  |            |
      | -7        | 2017-09-01 |            |            |            |            |            | 2018-01-05  | 2018-01-05  |            |
      | -8        | 2017-09-01 |            |            |            |            | 2017-12-23 |             | 2017-12-23  |            |
      | -9        | 2017-09-01 |            |            |            | 2018-01-15 |            | 2018-01-13  | 2018-01-13  |            |
      | -10       | 2017-09-01 |            |            |            |            | 2018-02-22 |             | 2018-02-22  |            |
      | -11       | 2017-09-01 |            |            |            |            |            |             | 2018-03-31  |            |
      | -12       | 2017-09-01 |            |            |            |            |            |             | 2018-03-31  |            |
      | -17       | 2015-05-05 |            |            |            |            |            | 2018-01-16  | 2018-01-16  |            |
      | -18       | 2016-11-17 |            |            |            | 2019-09-19 |            |             | 2019-09-19  |            |
      | -24       | 2017-07-07 |            |            |            |            | 2022-06-06 | 2022-02-02  | 2022-02-02  |            |
      | -25       | 2009-09-09 |            |            |            |            | 2019-09-08 | 2023-03-03  | 2023-03-03  |            |
      | -27       | 2014-09-09 |            |            |            |            |            |             |             | 2029-09-08 |
      | -28       | 2014-09-09 |            |            |            |            |            |             |             | 2031-03-08 |
      | -29       | 2017-02-08 |            | 2021-05-05 | 2020-08-07 |            |            |             | 2017-12-31  |            |
      | -30       | 2007-10-16 | 2020-12-30 |            | 2021-09-24 |            | 2021-01-02 |             | 2021-01-02  |            |
      | -32       |            |            |            |            |            |            |             |             |            |

  Scenario: Retrieve sentence details as a list
    When sentence details are requested of offenders for the logged in users caseloads
    Then "10" offenders are returned
    And "31" offenders in total

  Scenario Outline: Retrieve sentence details as a list filter and sort
    When sentence details are requested of offenders for the logged in users caseloads sorted by "bookingId" and filtered by "homeDetentionCurfewEligibilityDate:is:not null,and:conditionalReleaseDate:is:not null"
    And home detention curfew eligibility date matches "<hdced>"
    And confirmed release date matches "<confRelDate>"
    And release date matches "<releaseDate>"

    Examples:
      | hdced      | confRelDate | releaseDate |
      | 2019-06-02 |             | 2023-05-07  |

  Scenario Outline: Retrieve sentence details with sorting and with sentence date set
    When sentence details are requested of offenders for the logged in users caseloads sorted by "homeDetentionCurfewEligibilityDate,sentenceStartDate,bookingId", filtered by "sentenceStartDate:is:not null" with page size of "30"
    Then "20" offenders are returned
    And "20" offenders in total
    When I look at row "<row_num>"
    And sentence start date matches "<ssd>"
    And home detention curfew eligibility date matches "<hdced>"
    And confirmed release date matches "<confRelDate>"
    And release date matches "<releaseDate>"

    Examples:
      | row_num | ssd        | hdced      | confRelDate | releaseDate |
      | 1       | 2017-02-08 | 2019-06-02 |             | 2023-05-07  |
      | 2       | 2007-10-16 | 2020-12-30 |             | 2021-01-02  |
      | 3       | 2007-10-16 |            |             | 2021-08-31  |
      | 4       | 2009-09-09 |            | 2023-03-03  | 2023-03-03  |
      | 5       | 2014-09-09 |            |             |             |
      | 6       | 2014-09-09 |            |             |             |
      | 7       | 2015-03-16 |            |             | 2018-03-15  |
      | 8       | 2015-05-05 |            | 2018-01-16  | 2018-01-16  |
      | 9       | 2016-11-17 |            |             | 2019-09-19  |
      | 10      | 2016-11-22 |            | 2018-04-19  | 2018-04-19  |
      | 11      | 2017-02-08 |            |             | 2017-12-31  |
      | 12      | 2017-03-25 |            | 2018-04-23  | 2018-04-23  |
      | 13      | 2017-07-07 |            | 2022-02-02  | 2022-02-02  |
      | 14      | 2017-09-01 |            |             | 2018-03-31  |
      | 15      | 2017-09-01 |            |             | 2018-03-31  |
      | 16      | 2017-09-01 |            |             | 2018-02-22  |
      | 17      | 2017-09-01 |            | 2018-01-13  | 2018-01-13  |
      | 18      | 2017-09-01 |            |             | 2017-12-23  |
      | 19      | 2017-09-01 |            | 2018-01-05  | 2018-01-05  |
      | 20      | 2017-09-01 |            |             | 2018-05-15  |

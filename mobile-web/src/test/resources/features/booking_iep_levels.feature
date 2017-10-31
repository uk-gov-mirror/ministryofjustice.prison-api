@global
Feature: Booking Incentives & Earned Privileges

  Acceptance Criteria
  A logged on staff user can retrieve an IEP summary for an offender booking:
    - with IEP details.
    - without IEP details.
  The returned IEP level for an offender is the IEP level for the IEP history record that has the latest IEP date.
  If offender has multiple IEP history records with same IEP date, the IEP level for the offender is the IEP level for
   the IEP history record which has the highest IEP level sequence number (of those records with same IEP date).

  Background:
    Given a user has authenticated with the API

  Scenario Outline: Retrieve IEP summary for an offender (without IEP details).
    When an IEP summary only is requested for an offender with booking id "<bookingId>"
    Then IEP summary is returned with IEP level of "<iepLevel>"
    And IEP summary contains "<iepDetailCount>" detail records
    And IEP days since review is correct for IEP date of "<iepDate>"

    Examples:
      | bookingId | iepLevel | iepDetailCount | iepDate    |
      | -1        | Standard | 0              | 2017-08-15 |
      | -2        | Basic    | 0              | 2017-09-06 |
      | -3        | Enhanced | 0              | 2017-10-12 |

  Scenario Outline: Retrieve IEP summary for an offender (with IEP details).
    When an IEP summary, with details, is requested for an offender with booking id "<bookingId>"
    Then IEP summary is returned with IEP level of "<iepLevel>"
    And IEP summary contains "<iepDetailCount>" detail records
    And IEP days since review is correct for IEP date of "<iepDate>"

    Examples:
      | bookingId | iepLevel | iepDetailCount | iepDate    |
      | -1        | Standard | 1              | 2017-08-15 |
      | -2        | Basic    | 2              | 2017-09-06 |
      | -3        | Enhanced | 4              | 2017-10-12 |

  Scenario: Retrieve IEP summary for an existing offender that does not have any IEP detail records.
    When an IEP summary, with details, is requested for an offender with booking id "-9"
    Then resource not found response is received from bookings IEP summary API

  Scenario: The logged on staff user's caseload does not include the booking id
    When an IEP summary with booking id in different caseload is requested
    Then resource not found response is received from bookings IEP summary API
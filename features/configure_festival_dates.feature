Feature: Configurable Festival Dates
  In order to easily use the site for subsequent festivals
  As an administrator
  I want to configure the festival start and end dates
  
  @nowebmock
  Scenario: If I do not provide credentials, access is denied
    When I go to the dates settings page
    Then I should be asked to authenticate for the "Edbookfest-mobile administration" realm
    And I should not see "date"
  
  @nowebmock
  Scenario: If I provide credentials, I can see the current configuration
    Given I authenticate with HTTP basic authentication
    When I go to the dates settings page
    Then the title should be "Settings - Festival Dates"
    And the section title should be "Settings"
    And the page heading should be "Festival Dates"
    And the "festival_start_date" field should contain "13/08/2011"
    And the "festival_end_date" field should contain "29/08/2011"
    
  @nowebmock
  Scenario: If I set new dates, they immediately take effect
    Given I authenticate with HTTP basic authentication
    And I go to the dates settings page
    And I fill in the following:
      | festival_start_date | 11/08/2012 |
      | festival_end_date   | 27/08/2012 |
    And I press "submit"
    And there is an event called "Joe Bloggs"
    When I go to the calendar page
    Then I should see "August 2012"
    And there should be a date link on the 11th
    And there should not be a date link on the 10th
    And there should be a date link on the 27th
    And there should not be a date link on the 28th
    And there should be 17 date links
    
  @nowebmock
  Scenario: If I set invalid dates, I see errors
    Given I authenticate with HTTP basic authentication
    And I go to the dates settings page
    And I fill in the following:
      | festival_start_date | 30/02/2011 |
      | festival_end_date   | 30/02/2011 |
    When I press "submit"
    Then I should be on the dates settings page
    And I should see "Please enter a start date in day/month/year format"
    And I should see "Please enter an end date in day/month/year format"


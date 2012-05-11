Feature: Coming Soon page
  In order to understand why there are no events listed
  As a festival-goer
  I want to see when the programme will be launched
  
  @nowebmock @wip
  Scenario Outline: Before the programme is launched, all pages redirect to the coming soon page
    Given today is 01/05/2011
    And there are no events in the database
    When I go to <requested_page>
    Then I should be on the coming soon page
    
    Examples:
      | requested_page                   |
      | the home page                    |
      | the calendar page                |
      | the listings page for 13/08/2011 |
  
  @nowebmock @wip
  Scenario: The coming soon page explains to the user that the programme has not yet launched
    Given today is 01/05/2011
    And there are no events in the database
    When I go to the coming soon page
    Then the section title should be "Coming Soon"

  @nowebmock @wip
  Scenario: If the user arrives on the coming soon page once events are available they are taken to the calendar
    Given today is 01/05/2011
    And there is 1 event for 13/08/2011 starting at 09:00
    When I go to the coming soon page
    Then I should be on the calendar page

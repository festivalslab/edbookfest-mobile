Feature: Events calendar
  In order to see when the festival is on
  As a festival-goer
  I want to see which days have events
  
  Scenario: Show that user is in Events section
    Given I am on the calendar page
    Then the title should be "Events"
    And the theme should be "events"
    
  Scenario: Show every day in August 2011
    Given I am on the calendar page
    Then there should be 31 days in the calendar
    And I should see "August 2011"
    
  Scenario: Only festival days are linked
    Given I am on the calendar page
    Then there should be a date link on the 13th
    And there should not be a date link on the 12th
    And there should be a date link on the 29th
    And there should not be a date link on the 30th
    And there should be 17 date links
    
  Scenario: Highlight today
    Given today is 22/08/2011
    When I go to the calendar page
    Then the 22nd should be highlighted
    
  Scenario: Dates link through to listings page
    Given I am on the calendar page
    When I click on day 22
    Then I should be on the listings page for 22/08/2011
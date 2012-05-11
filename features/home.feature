Feature: Home page variations during and outside of Festival time
  In order to quickly see what is on today during the Festival
  As a festival-goer
  I want to see a list of events that are on today when I go to the home page
  
  @nowebmock
  Scenario: Before festival starts, calendar is shown
    Given today is 12/08/2011
    And there is an event called "Joe Bloggs"
    When I go to the home page
    Then I should be on the calendar page

  @nowebmock
  Scenario: During festival, before events start for the day, today's events are shown
    Given today is 13/08/2011 and the time is 08:00
    And there are 2 events for 13/08/2011 starting at 09:00
    When I go to the home page
    Then I should see 2 events
    And I should not see "On now at the Festival"
    And I should see "Today at the Festival"
  
  @nowebmock
  Scenario: During festival, when events are on (with 15 mins grace), current events are shown
    Given today is 13/08/2011 and the time is 16:25
    And there is 1 event for 13/08/2011 starting at 16:00
    And there is 1 event for 13/08/2011 starting at 16:39
    And there is 1 event for 13/08/2011 starting at 16:41
    When I go to the home page
    Then I should see "On now at the Festival"
    And I should see 2 events on now
    
  @nowebmock
  Scenario: During festival, when events are finished, but less than 15 minutes ago, these events are shown
    Given today is 13/08/2011 and the time is 16:25
    And there is 1 event for 13/08/2011 starting at 15:11 
    And there is 1 event for 13/08/2011 starting at 15:09
    When I go to the home page
    Then I should see "On now at the Festival"
    And I should see 1 events on now
    
  @nowebmock
  Scenario: During festival, after day's events have finished, today's events are shown
    Given today is 13/08/2011 and the time is 22:30
    And there are 2 events for 13/08/2011 starting at 09:00
    When I go to the home page
    Then I should see 2 events
    And I should not see "On now at the Festival"
    And I should see "Today at the Festival"
  
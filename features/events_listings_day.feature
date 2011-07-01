Feature: Events listings for one day
  In order to discover events at the book festival on a particular day
  As a festival-goer
  I want to view a chronological list of events for a single day
  
  Scenario: Shows chosen date
    Given I am on the listings page for 22/08/2011
    Then the page heading should be "Mon 22 Aug 2011"

  Scenario: Events are from only the day chosen
    Given there are 2 events for 22/08/2011 starting at 14:00
    And there is 1 event for 23/08/2011 starting at 14:00
    When I go to the listings page for 22/08/2011
    Then I should see 2 events
  
  Scenario: Events are ordered by start time
    Given there are 2 events for 22/08/2011 starting at 14:00
    When I go to the listings page for 22/08/2011
    Then event 1 starts before event 2
  
  Scenario: User is shown start time, title and subtitle
    Given there is 1 event for 22/08/2011 starting at 14:00
    When I go to the listings page for 22/08/2011
    Then event 1 has a start time of "14:00"
    And event 1 has a datetime of "2011-08-22T14:00:00+01:00"
    And event 1 has a title of "Event title"
    And event 1 has a subtitle of "Event subtitle"
  
  Scenario: Clicking an event navigates to event detail page
    Given there is 1 event for 22/08/2011 starting at 14:00
    When I go to the listings page for 22/08/2011
    And I click on event 1
    Then I should be on the event detail page for event 1
  
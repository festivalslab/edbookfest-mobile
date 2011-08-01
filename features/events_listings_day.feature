Feature: Events listings for one day
  In order to discover events at the book festival on a particular day
  As a festival-goer
  I want to view a chronological list of events for a single day
  
  @nowebmock
  Scenario: Shows chosen date
    Given I am on the listings page for 22/08/2011
    Then the page heading should be "Mon 22 Aug 2011"

  @nowebmock
  Scenario: Events are from only the day chosen
    Given there are 2 events for 22/08/2011 starting at 14:00
    And there is 1 event for 23/08/2011 starting at 14:00
    When I go to the listings page for 22/08/2011
    Then I should see 2 events
    
  @nowebmock
  Scenario: Events are ordered by start time
    Given there are 2 events for 22/08/2011 starting at 14:00
    When I go to the listings page for 22/08/2011
    Then event 1 starts before event 2
  
  @nowebmock
  Scenario: Events with the same start time are ordered by title
    Given there are 3 events for 22/08/2011 with the same start time
    When I go to the listings page for 22/08/2011
    Then event 1 has a title of "Event x"
    And event 2 has a title of "Event y"
    And event 3 has a title of "Event z"
  
  @nowebmock
  Scenario: User is shown start time, title and subtitle
    Given there is 1 event for 22/08/2011 starting at 14:00
    When I go to the listings page for 22/08/2011
    Then event 1 has a start time of "14:00"
    And event 1 has a datetime of "2011-08-22T14:00:00+01:00"
    And event 1 has a title of "Event title"
    And event 1 has a subtitle of "Event subtitle"
  
  @nowebmock
  Scenario: Clicking an event navigates to event detail page
    Given there is 1 event for 22/08/2011 starting at 14:00
    When I go to the listings page for 22/08/2011
    And I click on event 1
    Then I should be on the event detail page for event 1
  
  @nowebmock  
  Scenario: Sold out events are marked
    Given there is 1 event for 22/08/2011 starting at 14:00
    And there is 1 sold out event for 22/08/2011 starting at 15:00
    When I go to the listings page for 22/08/2011
    Then event 1 is not sold out
    And event 2 is sold out
  
  @nowebmock  
  Scenario: Adult events are shown by default for each day
    Given there are 2 adult events for 22/08/2011 starting at 14:00
    And there are 3 child events for 22/08/2011 starting at 15:00
    When I go to the listings page for 22/08/2011
    Then I should see 2 events
    And event 1 has a datetime of "2011-08-22T14:00:00+01:00"
  
  @nowebmock  
  Scenario: Child events are shown by request
    Given there are 2 adult events for 22/08/2011 starting at 14:00
    And there are 3 child events for 22/08/2011 starting at 15:00
    When I go to the listings page for 22/08/2011
    And I click the Children tab
    Then I should see 3 events
    And event 1 has a datetime of "2011-08-22T15:00:00+01:00"
  
  @nowebmock  
  Scenario: Initial state of adult and children event tabs
    Given there are 2 adult events for 22/08/2011 starting at 14:00
    And there are 3 child events for 22/08/2011 starting at 15:00
    When I go to the listings page for 22/08/2011
    Then the Adult tab should be highlighted
    And the Children tab should not be highlighted
  
  @nowebmock  
  Scenario: Swapping adult and children event tabs
    Given there are 2 adult events for 22/08/2011 starting at 14:00
    And there are 3 child events for 22/08/2011 starting at 15:00
    When I go to the listings page for 22/08/2011
    And I click the Children tab
    Then the Children tab should be highlighted
    And the Adult tab should not be highlighted
  
  @nowebmock @javascript
  Scenario: Navigation from calendar to listings works with ajax partial load
    Given there are 2 adult events for 22/08/2011 starting at 14:00
    And I am on the calendar page
    When I click on day 22
    Then I should be on the listings page for 22/08/2011
    And I should see 2 events
    And the title should be "Events for Mon 22 Aug 2011"
  
  @nowebmock @javascript
  Scenario: Navigation from calendar to listings and back using back button works with ajax partial load
    Given there are 2 adult events for 22/08/2011 starting at 14:00
    And there are 2 child events for 22/08/2011 starting at 14:00
    And I am on the calendar page
    When I click on day 22
    And I wait until "events" is visible
    And I click the back button
    Then I should be on the calendar page
    And the title should be "Events calendar"
  
  
  
  
  
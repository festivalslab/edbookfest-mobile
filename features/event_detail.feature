Feature: Event detail
  In order to discover information about a single event
  As a festival-goer
  I want to view detailed information about an event on one page

  Scenario: Event detail page has accurate information
    Given there is an event called "Joe Bloggs"
    When I go to the "Joe Bloggs" event detail page
    Then the title should be "Joe Bloggs"
    And the event title should be "Joe Bloggs"
    And the event subtitle should be "Event subtitle"
    And the event title sponsors should be "Event title sponsors"
    And the event time should be "3:00pm, Mon 22 Aug 2011"
    And the event duration should be "60 mins"
    And the event venue should be "Event venue"
    And the event standfirst should be "Event standfirst"
    And the event description should be "Event description"
    And the event price should be "£10 (£8)"
    And the event image should be "/event/image.jpg" with alt text "Joe Bloggs"
    And the event theme should be "Event theme"
    And the event buy tickets button should be "http://edbookfest.co.uk/event/buy"
    
  Scenario: Event detail page doesn't render blocks when no content is present
    Given there is an event called "Joe Bloggs" without optional data
    When I go to the "Joe Bloggs" event detail page
    Then the event subtitle is missing
    And the event title sponsors is missing
    And the event standfirst is missing
    And the event description is missing
    And the event price is missing
    And the event image is missing
    And the event theme is missing
    And the event buy tickets button is missing
    And the event duration is missing
    And the event venue is missing
    
  Scenario: Event detail page shows sold out when event is sold out
    Given there is a sold out event called "Joe Bloggs"
    When I go to the "Joe Bloggs" event detail page
    Then the event is sold out
    And the event buy tickets button is missing
    And the event price is missing
  

Feature: Event detail
  In order to discover information about a single event
  As a festival-goer
  I want to view detailed information about an event on one page

  @wip
  Scenario: Event detail page has accurate information
    Given there is an event called "Joe Bloggs"
    When I go to the "Joe Bloggs" event detail page
    Then show me the page
    And the title should be "Joe Bloggs"
    And the event title should be "Joe Bloggs"
    And the event subtitle should be "Event subtitle"
    And the event title sponsors should be "Event title sponsors"
    And the event start time should be "3:00pm"
    And the event duration should be "60 mins"
    And the event venue should be "Event venue"
    And the event standfirst should be "Event standfirst"
    And the event description should be "Event description"
    And the event price should be "£10"
    And the event image should be "/event/image.jpg"
    And the event theme should be "Event theme"

  
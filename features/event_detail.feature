Feature: Event detail
  In order to discover information about a single event
  As a festival-goer
  I want to view detailed information about an event on one page

  Scenario: Event detail page has accurate information
    Given there is an event called "Joe Bloggs"
    When I go to the "Joe Bloggs" event detail page
    Then the title should be "Joe Bloggs"
  
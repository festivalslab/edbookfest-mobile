Feature: Author detail
  In order to find out more about a particular author
  As a festival-goer
  I want to view details about an author

  Scenario: Author detail shows accurate information
    Given there is an author called "Joe Bloggs"
    When I go to the "Joe Bloggs" author detail page
    Then the title should be "Joe Bloggs"
    And the section title should be "Authors"
    And the page heading should be "Joe Bloggs"

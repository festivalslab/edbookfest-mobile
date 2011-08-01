Feature: Author detail
  In order to find out more about a particular author
  As a festival-goer
  I want to view details about an author

  @amazon_search
  Scenario: Author detail shows accurate information
    Given there is an author called "Joe Bloggs"
    When I go to the "Joe Bloggs" author detail page
    Then the title should be "Joe Bloggs"
    And the section title should be "Authors"
    And the page heading should be "Joe Bloggs"
    
  @amazon_search
  Scenario: Tab navigation for authors
    Given there is an author called "Joe Bloggs"
    When I go to the "Joe Bloggs" author detail page
    Then I should see 2 tabs
    And tab 1 should be "Bibliography"
    And tab 2 should be "Guardian articles"
    And tab 1 is highlighted
  
  @amazon_search
  @guardianapi
  Scenario: Tab navigation navigates between author pages
    Given there is an author called "Joe Bloggs"
    When I go to the "Joe Bloggs" author detail page
    And I click the Guardian articles tab
    Then I am on the "Joe Bloggs" author articles page
    
  @amazon_search
  Scenario: Bibliography shows 10 books for author with more than 10 books
    Given there is an author called "Ian Rankin"
    When I go to the "Ian Rankin" author detail page
    Then the author should have 10 books
  
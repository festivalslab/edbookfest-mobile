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
    
  @amazon_search
  Scenario: Bibliography show correct details for an item
    Given there is an author called "Ian Rankin"
    When I go to the "Ian Rankin" author detail page
    Then bibliography book 1 title should be "Knots And Crosses"
    And bibliography book 1 authors should be "Ian Rankin"
    And bibliography book 1 publication date should be "7 August 2008"
    And bibliography book 1 jacket image should have source of "http://ecx.images-amazon.com/images/I/419MNIz1-nL._SL160_.jpg"
  
  @amazon_search
  Scenario: Bibliography shows message when no books found
    Given there is an author called "Blkajlasdkf Boiulkjwlkjefr"
    When I go to the "Blkajlasdkf Boiulkjwlkjefr" author detail page
    Then the author should not have books
    And I should see "Sorry, no books were found for Blkajlasdkf Boiulkjwlkjefr"
  
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
  
  Scenario: Author detail shows author image when available
    Given there is an author called "Joe Bloggs" with an image
    When I go to the "Joe Bloggs" author detail page
    Then the page heading should be "Joe Bloggs"
    And the author image should be "http://author.image/image.jpg"
  
  Scenario: Author detail does not show author image when not available
    Given there is an author called "Joe Bloggs"
    When I go to the "Joe Bloggs" author detail page
    Then the author image is missing
    
  Scenario: Tab navigation for authors
    Given there is an author called "Joe Bloggs"
    When I go to the "Joe Bloggs" author detail page
    Then I should see 2 tabs
    And tab 1 should be "Bibliography"
    And tab 2 should be "Guardian articles"
    And tab 1 is highlighted
  
  @guardianapi
  Scenario: Tab navigation navigates between author pages
    Given there is an author called "Joe Bloggs"
    When I go to the "Joe Bloggs" author detail page
    And I click the Guardian articles tab
    Then I am on the "Joe Bloggs" author articles page

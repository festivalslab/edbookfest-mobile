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
  

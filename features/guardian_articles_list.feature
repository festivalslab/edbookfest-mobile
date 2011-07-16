Feature: Guardian articles list
  In order to read interesting articles about or by an author
  As a festival-goer
  I want to view a list of the 10 latest Guardian articles mentioning an author

  Scenario: Author article page shows correct page details
    Given there is an author called "Joe Bloggs"
    When I go to the "Joe Bloggs" author articles page
    Then the title should be "Joe Bloggs – Guardian articles"
    And the section title should be "Authors"
    And the page heading should be "Joe Bloggs"
  
  @wip
  Scenario: Author article page shows 10 articles
    Given there is an author called "Joe Bloggs"
    When I go to the "Joe Bloggs" author articles page
    Then I should see 10 articles
    And article 1 title is "Joe Bloggs article 1 title"
  

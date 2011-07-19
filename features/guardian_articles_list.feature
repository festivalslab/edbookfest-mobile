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
  
  Scenario: Author article page shows articles (real API)
    Given there is an author called "Ian Rankin"
    When I go to the "Ian Rankin" author articles page
    Then I should see at least 1 article
  
  Scenario: Author article page shows correct article details
    Given there is an author called "Ian Rankin"
    When I go to the "Ian Rankin" author articles page
    Then article 1 should have a title
    And article 1 should have a date
    And article 1 should have date text
    And article 1 should link to an article

  Scenario: Author article page shows message when there are no articles
    Given there is an author called "Alksadlfkjoi Bkajlaksdjflk"
    When I go to the "Alksadlfkjoi Bkajlaksdjflk" author articles page
    Then I should see 0 articles
    And I should see "No Guardian articles were found for Alksadlfkjoi Bkajlaksdjflk"
    
  Scenario: Tab navigation navigates between author pages
    Given there is an author called "Joe Bloggs"
    When I go to the "Joe Bloggs" author articles page
    And I click the Bibliography tab
    Then I am on the "Joe Bloggs" author detail page
    
  Scenario: Powered by Guardian logo is displayed
    Given there is an author called "Joe Bloggs"
    When I go to the "Joe Bloggs" author articles page
    Then I should see the Powered by Guardian logo
  
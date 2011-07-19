Feature: Guardian articles detail
  In order find out more about a particular author
  As a festival-goer
  I want to read an individual article of my choice
  
  Scenario: Article has standard information
    Given there is an author called "Jo Nesbø"
    And I am on the "Jo Nesbø" author article detail page for books/2011/jan/22/the-leopard-jo-nesbo-review
    Then the title should be "The Leopard by Jo Nesbø"
    And the section title should be "Authors"
    And the page heading should be "Jo Nesbø"
  
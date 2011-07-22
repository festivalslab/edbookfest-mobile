Feature: Guardian articles detail
  In order find out more about a particular author
  As a festival-goer
  I want to read an individual article of my choice
  
  @guardianapi
  Scenario: Article has standard information
    Given there is an author called "Jo Nesbø"
    And I am on the "Jo Nesbø" author article detail page for books/2011/jan/22/the-leopard-jo-nesbo-review
    Then the title should be "The Leopard by Jo Nesbø"
    And the section title should be "Authors"
    And the page heading should be "Jo Nesbø"
  
  @guardianapi  
  Scenario: Article fields are displayed
    Given there is an author called "Jo Nesbø"
    When I am on the "Jo Nesbø" author article detail page for books/2011/jan/22/the-leopard-jo-nesbo-review
    Then the article headline should be "The Leopard by Jo Nesbø"
    And the article standfirst should be "Laura Wilson goes on a Nordic murder spree"
    And the article byline should be "Laura Wilson"
    And the article publication should be "The Guardian"
    And the article publication date should have a value of "2011-01-22T00:05:39Z"
    And the article publication date should be "22 January 2011"
    And the article link should have a url of "http://www.guardian.co.uk/books/2011/jan/22/the-leopard-jo-nesbo-review"
    And the article body should contain "Since The Girl With the Dragon Tattoo was published in 2008"
  
  @guardianapi  
  Scenario: Tab navigation
    Given there is an author called "Jo Nesbø"
    When I am on the "Jo Nesbø" author article detail page for books/2011/jan/22/the-leopard-jo-nesbo-review
    Then I should see 2 tabs
    And tab 1 should be "Bibliography"
    And tab 2 should be "Guardian articles"
    And tab 2 is highlighted
  
  @guardianapi  
  Scenario: If article content not available, user is informed 
    Given there is an author called "Jo Nesbø"
    When I am on the "Jo Nesbø" author article detail page for books/2010/nov/28/writers-favourite-translations
    Then the article headline should be "Writers pick their favourite translations..."
    And the article standfirst should be "Novelists and translators on the translated books that have impressed them most"
    And the article byline should be "Various"
    And the article publication should be "The Observer"
    And the article publication date should have a value of "2010-11-28T00:08:00Z"
    And the article publication date should be "28 November 2010"
    And the article link should have a url of "http://www.guardian.co.uk/books/2010/nov/28/writers-favourite-translations"
    And the article body should be "This article is only available on The Guardian website."
  
  
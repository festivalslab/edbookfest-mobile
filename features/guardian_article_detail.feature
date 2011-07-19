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
    

  
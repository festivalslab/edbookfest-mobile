Feature: Book detail page
  In order to see whether I am interested in a particular book
  As a potential book buyer
  I want to read details about an individual book and see where I can buy it

  @amazon_lookup
  Scenario: standard locating information is shown
    Given there is a book called "The Leopard" with isbn 9780099548973
    When I go to the "The Leopard" book detail page
    Then the title should be "The Leopard"
    And the section title should be "Books"
    And the page heading should be "The Leopard" 
    
  @amazon_lookup
  Scenario: Basic book information is shown for a book with a short description and review
    Given there is a book called "The Complaints" with isbn 9781409103479
    When I go to the "The Complaints" book detail page
    Then the book authors should be "Ian Rankin"
    And the book short description should be "The brand new No.1 bestseller from Britain's best-loved crime writer..."
    And the book jacket image should have a url of "http://ecx.images-amazon.com/images/I/51sg218Ru8L._SL160_.jpg"
    And the book amazon review should contain "It must be a double-edged sword to be Ian Rankin. Of course it's comforting to be Britain's best-selling male crime writer -- and to have created one of the most iconic characters in detective fiction in the irascible (and indomitable) D. I. Jack Rebus."
    And the book publisher should be "Orion"
    And the book publication date should be "5 August 2010"
    And the book page count should be "496 pages"
    
  @amazon_lookup
  Scenario: Description not shown when not available
    Given there is a book called "The Leopard" with isbn 9780099548973
    When I go to the "The Leopard" book detail page
    Then the book short description should not be present
  
  @amazon_lookup
  Scenario: Amazon review not shown when not available
    Given there is a book called "The Leopard" with isbn 9780099548973
    When I go to the "The Leopard" book detail page
    Then the book amazon review should not be present
    
  @amazon_lookup
  Scenario: Book jacket image not shown when not present
    Given there is a book called "The Stolen Sister" with isbn 9781846471292
    When I go to the "The Stolen Sister" book detail page
    Then the book jacket image should not be present
    
  @amazon_lookup
  Scenario: Only book title and author is shown for an unsuccessful amazon lookup
    Given there is a book called "An Unknown Book" with isbn 9780000000000
    When I go to the "An Unknown Book" book detail page
    Then the title should be "An Unknown Book"
    And the section title should be "Books"
    And the page heading should be "An Unknown Book"
    And I should see "Details for An Unknown Book could not be found."
    And the book authors should not be present
    And the book jacket image should not be present
    And the book short description should not be present
    And the book amazon review should not be present
    And the book publisher should not be present
    And the book publication date should not be present
    And the book page count should not be present
    
  @amazon_lookup
  Scenario: Where there are multiple authors, all are shown
    Given there is a book called "Pathways" with isbn 9780852652268
    When I go to the "Pathways" book detail page
    Then the book authors should be "David Stewart, Nicholas Rudd-Jones"

  @amazon_lookup
  @javascript
  Scenario: Amazon review is invisible by default
    Given there is a book called "The World's Wife" with isbn 9780330372220
    When I go to the "The World's Wife" book detail page
    Then the book amazon review should not be visible
    And the book amazon review link should be "SHOW AMAZON REVIEW"

  @amazon_lookup
  @javascript
  Scenario: Amazon review can be shown
    Given there is a book called "The World's Wife" with isbn 9780330372220
    When I go to the "The World's Wife" book detail page
    And I click the book amazon review link
    Then the book amazon review should be visible
    And the book amazon review link should be "HIDE AMAZON REVIEW"

  @amazon_lookup
  @javascript
  Scenario: Amazon review can be hidden again
    Given there is a book called "The World's Wife" with isbn 9780330372220
    When I go to the "The World's Wife" book detail page
    And I click the book amazon review link
    And I click the book amazon review link
    Then the book amazon review should not be visible
    And the book amazon review link should be "HOW AMAZON REVIEW"

  
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
    And the book amazon affiliate link should have a url that contains "http://www.amazon.co.uk/Complaints-Ian-Rankin/dp/1409103471"
    
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
    Given there is a book called "Scottish Tales of Adventure: World War I" with isbn 9781841589329
    When I go to the "Scottish Tales of Adventure: World War I" book detail page
    Then the book jacket image should not be present
    
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
    And the book amazon review link should be "SHOW AMAZON REVIEW"
    
  @kindle_lookup
  Scenario: Kindle link shown for book that has a Kindle edition
    Given there is a book called "India" with isbn 9781846142147
    When I go to the "India" book detail page
    Then the book kindle link should have a url that contains "http://www.amazon.co.uk/India-A-Portrait-ebook/dp/B004NNULLI"
  
  @kindle_lookup
  Scenario: Kindle link not shown for book that has no Kindle edition
    Given there is a book called "Silly Doggy" with isbn 9781848775565
    When I go to the "Silly Doggy" book detail page
    Then the book kindle link should not be present
    
  @itunes_lookup
  Scenario: itunes link shown for book that has an iBooks edition
    Given there is a book called "India" with isbn 9781846142147
    When I go to the "India" book detail page
    Then the book iTunes link should have a url that contains "http://itunes.apple.com/gb/book/india/id419753457"
    
  @itunes_lookup
  Scenario: itunes link not shown for book that has no iBooks edition
    Given there is a book called "Silly Doggy" with isbn 9781848775565
    When I go to the "Silly Doggy" book detail page
    Then the book iTunes link should not be present
    
  @amazon_lookup
  Scenario Outline: Stock availability status is shown
    Given there is a book called "The Leopard" with isbn 9780099548973
    And the book "The Leopard" has "<status>" stock availability
    When I go to the "The Leopard" book detail page
    Then I should see "<text>"

    Examples:
      | status    | text                                |
      | available | This book is available              |
      | limited   | This book has limited availability  |
      | none      | This book is currently out of stock |
      
  @amazon_lookup
  Scenario: Stock availability status is shown for book with nil stock status
    Given there is a book called "The Leopard" with isbn 9780099548973
    When I go to the "The Leopard" book detail page
    Then I should see "This book is currently out of stock"
    
  @amazon_lookup
  Scenario: Book detail shown for book that has no model
    When I go to the book detail page with isbn "9780007276912"
    Then the book authors should be "Mark Mills"
    And the book jacket image should have a url of "http://ecx.images-amazon.com/images/I/51KyDgk59IL._SL160_.jpg"
    And the book publisher should be "Harper"
    And the book publication date should be "7 July 2011"
    And the book page count should be "400 pages"
    And the book amazon affiliate link should have a url that contains "http://www.amazon.co.uk/House-Hanged-Mark-Mills/dp/0007276915" 

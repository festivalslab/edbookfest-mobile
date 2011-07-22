Feature: Book detail page
  In order to see whether I am interested in a particular book
  As a potential book buyer
  I want to read details about an individual book and see where I can buy it

  Scenario: standard locating information is shown
    Given there is a book called "The Leopard" with isbn 9780099548973
    When I go to the "The Leopard" book detail page
    Then the title should be "The Leopard"
    And the section title should be "Books"
    And the page heading should be "The Leopard"
  

Feature: Event detail
  In order to discover information about a single event
  As a festival-goer
  I want to view detailed information about an event on one page

  Scenario: Event detail page has accurate information
    Given there is an event called "Joe Bloggs"
    When I go to the "Joe Bloggs" event detail page
    Then the title should be "Joe Bloggs"
    And the event title should be "Joe Bloggs"
    And the event subtitle should be "Event subtitle"
    And the event title sponsors should be "Event title sponsors"
    And the event time should be "3:00pm, Mon 22 Aug 2011"
    And the event duration should be "60 mins"
    And the event venue should be "Event venue"
    And the event standfirst should be "Event standfirst"
    And the event description should be "Event description"
    And the event price should be "£10 (£8)"
    And the event image should be "/event/image.jpg" with alt text "Joe Bloggs"
    And the event theme should be "Event theme"
    And the event buy tickets button should be "http://edbookfest.co.uk/event/buy"
    
  Scenario: Event detail page doesn't render blocks when no content is present
    Given there is an event called "Joe Bloggs" without optional data
    When I go to the "Joe Bloggs" event detail page
    Then the event subtitle is missing
    And the event title sponsors is missing
    And the event standfirst is missing
    And the event description is missing
    And the event price is missing
    And the event image is missing
    And the event theme is missing
    And the event buy tickets button is missing
    And the event duration is missing
    And the event venue is missing
    
  Scenario: Event detail page shows sold out when event is sold out
    Given there is a sold out event called "Joe Bloggs"
    When I go to the "Joe Bloggs" event detail page
    Then the event is sold out
    And the event buy tickets button is missing
    And the event price is missing
    
  Scenario: Event detail page shows featured authors
    Given there are 2 authors appearing at the "Author debate" event
    When I go to the "Author debate" event detail page
    Then I should see "Featured authors"
    And the event should have 2 authors
    And event author 1 should be "First Last1"
    And event author 2 should be "First Last2"
    
  Scenario: Event detail page does not show featured authors if none exist
    Given there are 0 authors appearing at the "Author debate" event
    When I go to the "Author debate" event detail page
    Then I should not see "Featured authors"
    And the event should not have authors
    
  Scenario: Event detail page links to featured authors
    Given there are 2 authors appearing at the "Author debate" event
    When I go to the "Author debate" event detail page
    And I click on author 1
    Then I should be on the author detail page for author 1
  
  @amazon_lookup
  Scenario: Event detail page shows featured books
    Given there are 2 books featured at the "Author debate" event
    And the book "Book Title 1" has "available" stock availability
    When I go to the "Author debate" event detail page
    Then I should see "Featured books"
    And the event should have 2 books
    And event book 1 should be "Book Title 1"
    And event book 2 should be "Book Title 2"
    And event book 1 should be in stock
    And event book 2 should not be in stock
  
  Scenario: Event detail featured book shows correct details
    Given there is 1 book featured at the "Author debate" event
    When I go to the "Author debate" event detail page
    Then event book 1 image is "http://book.image/image.jpg"
  
  Scenario: Event detail page does not show featured books if none exist
    Given there are 0 books featured at the "Author debate" event
    When I go to the "Author debate" event detail page
    Then I should not see "Featured books"
    And the event should not have books
    
  Scenario: Book image is not shown if empty
    Given there is 1 book featured at the "Author debate" event without an image
    When I go to the "Author debate" event detail page
    Then the event should have 1 book
    And event book 1 image is not present
  
  @amazon_lookup
  Scenario: Event detail page links to featured books
    Given there are 2 books featured at the "Author debate" event
    When I go to the "Author debate" event detail page
    And I click on book 1
    Then I should be on the book detail page for book 1
  

Feature: Festival themes can be edited through the site
  In order to manage festival themes
  As an administrator
  I want to edit theme active times and upload new images
  
  @nowebmock
  Scenario: If I do not provide credentials, access is denied
    When I go to the theme list page
    Then I should be asked to authenticate for the "Edbookfest-mobile administration" realm
    And I should not see "theme"
    
  @nowebmock
  Scenario: Navigation elements are displayed
    Given I authenticate with HTTP Basic Authentication
    When I go to the theme list page
    Then the title should be "Settings - Festival Themes"
    And the section title should be "Settings"
    And the page heading should be "Festival Themes"
  
  @nowebmock
  Scenario: User sees the active time and images for an existing theme
    Given the following theme:
      | show_from        | high_file_name | medium_file_name | low_file_name | shortcut_file_name | splash_file_name |
      | 2011-06-20 12:00 | aaa_h.png      | aaa_m.png        | aaa_l.png     | aaa_sht.png        | aaa_spl.png      |
    And I authenticate with HTTP Basic Authentication
    When I go to the theme edit page for theme 1
    Then the "show_from" field should contain "20/06/2011 12:00"
    And the "high-res" image source should match "^http://s3.amazonaws.com/.+/aaa_h\.png$"
    And the "medium-res" image source should match "^http://s3.amazonaws.com/.+/aaa_m\.png$"
    And the "low-res" image source should match "^http://s3.amazonaws.com/.+/aaa_l\.png$"
    And the "shortcut" image source should match "^http://s3.amazonaws.com/.+/aaa_sht\.png$"
    And the "splash" image source should match "^http://s3.amazonaws.com/.+/aaa_spl\.png$"
  
  @nowebmock
  Scenario: User is shown a blank form for a new theme
    Given I authenticate with HTTP Basic Authentication
    When I go to the theme edit page for a new theme
    Then the "show_from" field should contain ""
    And the "high-res" image source should be empty
    And the "medium-res" image source should be empty
    And the "low-res" image source should end be empty
    And the "shortcut" image source should end be empty
    And the "splash" image source should end be empty
  
  @paperclip
  Scenario: User can create a new theme and upload images to Amazon S3 with secure URLs
    Given I authenticate with HTTP Basic Authentication
    When I go to the theme edit page for a new theme
    And I fill in "21/06/2012 12:00" in the "show_from" field
    And I attach "h.png" to the "high" field
    And I attach "m.png" to the "medium" field
    And I attach "l.png" to the "low" field
    And I attach "sht.png" to the "shortcut" field
    And I attach "splsh.png" to the "splash" field
    And I press "submit"
    Then I should be on the theme edit page for theme 1
    And the "show_from" field should contain "21/06/2012 12:00"
    And the images for theme 1 should have been uploaded to Amazon S3 with secure URLs
  
  @nowebmock
  Scenario: User sees an error if invalid date is entered
    Given I authenticate with HTTP Basic Authentication
    When I go to the theme edit page for a new theme
    And I fill in "35/06/2012 12:00" in the "show_from" field
    And I press "submit"
    Then I should be on the theme edit page for a new theme
    And I should see "Please enter a valid date and time in day/month/year hour:minute format"

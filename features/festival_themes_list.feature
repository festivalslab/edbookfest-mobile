Feature: Listing of configured festival themes
  In order to manage festival themes
  As an administrator
  I want to view a chronoligical list of the configured themes
  
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
  Scenario: Themes are ordered by active date
    Given there is a theme active from 12:00 on 21/06/2011
    And there is a theme active from 12:00 on 21/06/2012
    And I authenticate with HTTP Basic Authentication
    When I go to the theme list page
    Then theme 1 is active before theme 2
  
  @nowebmock
  Scenario: User is shown shortcut image, active status and active time
    Given the following themes:
      | show_from        | high_file_name | medium_file_name | low_file_name | shortcut_file_name | splash_file_name |
      | 2011-06-20 12:00 | aaa_h.png      | aaa_m.png        | aaa_l.png     | aaa_sht.png        | aaa_spl.png      |
      | 2012-06-21 12:00 | bbb_h.png      | bbb_m.png        | bbb_l.png     | bbb_sht.png        | bbb_spl.png      |
    And I authenticate with HTTP Basic Authentication
    And today is 13/08/2011 and the time is 08:00
    When I go to the theme list page
    Then I should see "20/06/2011 12:00" in theme 1
    And the theme 1 image source should match "^http://s3.amazonaws.com/.+/aaa_sht\.png$"
    And theme 1 should be active
    And theme 2 should not be active
    
  @nowebmock
  Scenario: Clicking a theme navigates to theme edit page
    Given there is a theme active from 12:00 on 21/06/2011
    And I authenticate with HTTP Basic Authentication
    When I go to the theme list page
    And I click on theme 1
    Then I should be on the theme edit page for theme 1
    
  @nowebmock
  Scenario: Clicking on create a theme navigates to new theme page
    Given I authenticate with HTTP Basic Authentication
    When I go to the theme list page
    And I click on create a theme
    Then I should be on the theme edit page for a new theme
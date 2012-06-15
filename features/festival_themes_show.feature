Feature: Configurable Festival Themes are shown to the user
  In order to brand the site for each festival
  As an administrator
  I want users to automatically see new icons and splash screens on launch day
  
  @nowebmock @wip
  Scenario Outline: The theme changes automatically when the festival launches
    Given today is 21/06/2012 and the time is <time>
    And the following themes:
      | show_from        | high_file_name | medium_file_name | low_file_name | shortcut_file_name | splash_file_name |
      | 2011-06-20 12:00 | aaa_h.png      | aaa_m.png        | aaa_l.png     | aaa_sht.png        | aaa_spl.png      |
      | 2012-06-21 12:00 | bbb_h.png      | bbb_m.png        | bbb_l.png     | bbb_sht.png        | bbb_spl.png      |
    When I go to the home page
    Then the "high-res apple touch icon" url should match "^http://s3.amazonaws.com/.+/<url_prefix>_h\.png$"
    And the "medium-res apple touch icon" url should match "^http://s3.amazonaws.com/.+/<url_prefix>_m\.png$"
    And the "low-res apple touch icon" url should match "^http://s3.amazonaws.com/.+/<url_prefix>_l\.png$"
    And the "shortcut icon" url should match "^http://s3.amazonaws.com/.+/<url_prefix>_sht\.png$"
    And the "splash screen image" url should match "^http://s3.amazonaws.com/.+/<url_prefix>_spl\.png$"
  
  Examples:
    | time  | url_prefix |
    | 11:59 | aaa        |
    | 12:00 | bbb        |

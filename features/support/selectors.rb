module HtmlSelectorsHelpers
  # Maps a name to a selector. Used primarily by the
  #
  #   When /^(.+) within (.+)$/ do |step, scope|
  #
  # step definitions in web_steps.rb
  #
  def selector_for(locator)
    case locator

    when "the page"
      "html > body"
      
    when /event (\d+)/
      "ul.events li:nth-child(#{$1})"
      
    when /tab (\d+)/
      "ul.tabs li:nth-child(#{$1})"
    
    when /article (\d+) date/
      "ul.articles li:nth-child(#{$1}) time"
      
    when /article (\d+) link/
      "ul.articles li:nth-child(#{$1}) a"
      
    when /article (\d+)/
      "ul.articles li:nth-child(#{$1})"
      
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #  when /^the (notice|error|info) flash$/
    #    ".flash.#{$1}"

    # You can also return an array to use a different selector
    # type, like:
    #
    #  when /the header/
    #    [:xpath, "//header"]

    # This allows you to provide a quoted selector as the scope
    # for "within" steps as was previously the default for the
    # web steps:
    when /^"(.+)"$/
      $1

    else
      raise "Can't find mapping from \"#{locator}\" to a selector.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(HtmlSelectorsHelpers)

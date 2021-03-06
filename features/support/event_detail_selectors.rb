module HtmlSelectorsHelpers
  # Maps a name to a selector. Used primarily by the
  #
  #   When /^(.+) within (.+)$/ do |step, scope|
  #
  # step definitions in web_steps.rb
  #
  def event_detail_selector_for(locator)
    case locator
      
    when "title"
      "h3"

    when "subtitle"
      "h4"
      
    when "title sponsors"
      "h5.title-sponsors"
      
    when "date"
      "time.date"
      
    when "standfirst"
      ".standfirst"
      
    when "description"
      ".description"
      
    when "price"
      ".price"
      
    when "image"
      "img.event"
      
    when "theme"
      ".theme"
      
    when "venue"
      ".venue"
    
    when "duration"
      ".duration"
      
    when "time"
      "time.start-time"
      
    when "buy tickets button"
      "a.buy-tickets"
      
    when /author (\d+)/
      "ul.authors li:nth-child(#{$1})"
      
    when /book (\d+)/
      "ul.amazon-books li:nth-child(#{$1})"

    else
      raise "Can't find mapping from \"#{locator}\" to a selector.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
      
  end
end
      
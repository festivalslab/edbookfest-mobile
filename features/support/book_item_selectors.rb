module HtmlSelectorsHelpers
  # Maps a name to a selector. Used primarily by the
  #
  #   When /^(.+) within (.+)$/ do |step, scope|
  #
  # step definitions in web_steps.rb
  #
  def book_item_selector_for(locator)
    case locator
      
    when "title"
      ".title"
      
    when "authors"
      ".authors"
      
    when "publication date"
      ".publication-date"
      
    when "jacket image"
      "img"
      
    when "binding"
      ".binding"
      
    when "more link"
      ".more-books"
      
    else
      raise "Can't find mapping from \"#{locator}\" to a selector.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
      
  end
end

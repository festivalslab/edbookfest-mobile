module HtmlSelectorsHelpers
  # Maps a name to a selector. Used primarily by the
  #
  #   When /^(.+) within (.+)$/ do |step, scope|
  #
  # step definitions in web_steps.rb
  #
  def book_selector_for(locator)
    case locator
      
    when "authors"
      ".book-detail .authors"
      
    when "short description"
      ".book-detail .short-description"
      
    when "publisher"
      ".book-info .publisher"
      
    when "publication date"
      ".book-info .publication-date"
      
    when "page count"
      ".book-info .page-count"
      
    when "jacket image"
      ".book-detail img.jacket"
      
    when "amazon review"
      ".book-detail .amazon-review"
      
    when "amazon review link"
      ".book-detail .amazon-review-link"
      
    when "amazon affiliate link"
      ".book-detail .amazon-affiliate-link"
      
    when "kindle link"
      ".book-detail .kindle-affiliate-link"
    
    when "iTunes link"
      ".book-detail .itunes-affiliate-link"
      
    when "availibility"
      ".book-detail .availability"
      
    else
      raise "Can't find mapping from \"#{locator}\" to a selector.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
      
  end
end

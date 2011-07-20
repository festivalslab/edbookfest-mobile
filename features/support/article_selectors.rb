module HtmlSelectorsHelpers
  # Maps a name to a selector. Used primarily by the
  #
  #   When /^(.+) within (.+)$/ do |step, scope|
  #
  # step definitions in web_steps.rb
  #
  def article_selector_for(locator)
    case locator
      
    when "headline"
      ".article-detail h4"
      
    when "standfirst"
      ".article-detail .standfirst"
      
    when "byline"
      ".article-detail .byline"
      
    when "publication date"
      ".article-detail time"
      
    when "publication"
      ".article-detail .publication"
      
    when "link"
      ".article-detail .guardian-link"
      
    when "body"
      ".article-detail .article-body"
      
    else
      raise "Can't find mapping from \"#{locator}\" to a selector.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
      
  end
end

module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'
      
    when /^the calendar page$/
      calendar_path
      
    when /^the listings page for (\d+)\/(\d+)\/(\d+)$/
      listings_path("#{$3}-#{$2}-#{$1}")
      
    when /^the event detail page for (\d)$/
      event_path(Event.find($1))
      
    when /^the "(.*)" event detail page$/
      event_path(Event.find_by_title($1))
      
    when /^the author detail page for (\d+)$/
      author_path(Author.find($1))
      
    when /^the "(\S+) (\S+)" author detail page$/
      author_path(Author.find_by_first_name_and_last_name($1, $2))
      
    when /^the "(\S+) (\S+)" author articles page$/
      author_articles_path(Author.find_by_first_name_and_last_name($1, $2))
      
    when /^the "(\S+) (\S+)" author article detail page for (.*)$/
      author_article_path(Author.find_by_first_name_and_last_name($1, $2), $3)
      
    when /^the book detail page for (\d)$/
      book_path(Book.find($1))

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)

Given /^there (?:is|are) (\d+) books? featured at the "([^\"]*)" event( without an image)?$/ do |book_count, event_title, no_image|
  event = Factory.build :event, :title => event_title
  books = []
  book_count.to_i.times do |i|
    if no_image
      books.push Factory.build(:book, :amazon_image => "")
    else
      books.push Factory.build(:book)
    end
  end
  book_count.to_i.times do |i|
    featured_book = Factory.create :featured_book, :event => event, :book => books[i]
  end
  event.save
end

Given /^there is a book called "([^\"]*)" with isbn (\d+)$/ do |book_title, isbn|
  book = Factory.create :book, :title => book_title, :isbn => isbn
end

Given /^the book "([^\"]*)" has "([^\"]*)" stock availability$/ do |book_title, availibility|
  book = Book.find_by_title book_title
  book.update_attribute :stock_status, availibility
end

When /^I click the book amazon review link$/ do
  page.find(book_selector_for("amazon review link")).click
end

Then /^the book jacket image should have a url of "([^\"]*)"$/ do |url|
  page.should have_css book_selector_for("jacket image"), :src => url
end

Then /^the book (.*) should be "([^\"]*)"$/ do |field, value|
  page.should have_css book_selector_for(field), :text => value, :visible => true
end

Then /^the book (.*) should contain "([^\"]*)"$/ do |field, value|
  page.should have_css book_selector_for(field), :content => value
end

Then /^the book (.*) should not be present$/ do |field|
  page.should_not have_css book_selector_for field
end

Then /^the book (.*) should be visible$/ do |field|
  page.should have_css book_selector_for(field), :visible => true
end

Then /^the book (.*) should not be visible$/ do |field|
  page.should have_css book_selector_for(field), :visible => false
end

Then /^the book (.*) should have a url that contains "([^\"]*)"$/ do |field, url_part|
  link = page.find book_selector_for(field)
  link['href'].should include(url_part)
end

Then /^the stock availability is "([^\"]*)"$/ do |availibility|
  page.should have_css book_selector_for("availibility"), :text => availibility
end

Then /^I should be on the "([^\"]*)" book detail page$/ do |title|
  current_path = URI.parse(current_url).path
  current_path.should == path_to("the \"#{title}\" book detail page")
end

Then /^I should be on the book detail page for isbn (\d+)$/ do |isbn|
  current_path = URI.parse(current_url).path
  current_path.should == path_to("the book detail page with isbn \"#{isbn}\"")
end

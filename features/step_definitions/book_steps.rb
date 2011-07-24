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

Then /^the book jacket image should have a url of "([^\"]*)"$/ do |url|
  page.should have_css book_selector_for("jacket image"), :src => url
end

Then /^the book (.*) should be "([^\"]*)"$/ do |field, value|
  page.should have_css book_selector_for(field), :text => value
end

Then /^the book (.*) should contain "([^\"]*)"$/ do |field, value|
  page.should have_css book_selector_for(field), :content => value
end

Then /^the book (.*) should not be present$/ do |field|
  page.should_not have_css book_selector_for field
end
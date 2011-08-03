Given /^there is an author called "(\S+) (\S+)"( with an image)?$/ do |first_name, last_name, image|
  attributes = { :first_name => first_name, :last_name => last_name }
  attributes[:image] = "http://author.image/image.jpg" if image
  author = Factory.create(:author, attributes)
end

Given /^there are (\d+) authors appearing at the "([^\"]*)" event$/ do |author_count, event_title|
  event = Factory.build(:event, :title => event_title)
  authors = []
  author_count.to_i.times do |i|
    authors.push Factory.build(:author)
  end
  author_count.to_i.times do |i|
    appearance = Factory.create(:appearance, :event => event, :author => authors[i])
  end
  event.save
end

When /^I click bibliography book (\d+)$/ do |index|
  find("ul.amazon-books li:nth-child(#{index}) a").click
end

Then /^the author image should be "([^\"]*)"$/ do |image_url|
  page.should have_css('img.author', :src => image_url)
end

Then /^the author image is missing$/ do
  page.should_not have_css('img.author')
end

Then /^the author should have (\d+) books$/ do |book_count|
  page.should have_css('ul.amazon-books li', :count => book_count)
end

Then /^the author should not have books$/ do
  page.should_not have_css('ul.amazon-books')
end

Then /^bibliography book (\d+) (.*) should be "([^\"]*)"$/ do |index, field, value|
  book = find "ul.amazon-books li:nth-child(#{index})"
  book.should have_css(bibliography_selector_for(field), :text => value)
end

Then /^bibliography book (\d+) (.*) should have source of "([^\"]*)"$/ do |index, field, value|
  book = find "ul.amazon-books li:nth-child(#{index})"
  book.should have_css(bibliography_selector_for(field), :src => value)
end

Then /^bibliography book (\d+) should be in stock$/ do |index|
  book = find "ul.amazon-books li:nth-child(#{index})"
  book.should have_content "in stock"
end

Then /^bibliography book (\d+) should not be in stock$/ do |index|
  book = find "ul.amazon-books li:nth-child(#{index})"
  book.should_not have_content "in stock"
end

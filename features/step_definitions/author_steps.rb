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

Then /^the author image should be "([^\"]*)"$/ do |image_url|
  page.should have_css('img.author', :src => image_url)
end

Then /^the author image is missing$/ do
  page.should_not have_css('img.author')
end

Then /^the author should have (\d+) books$/ do |book_count|
  page.should have_css('ul.books li', :count => book_count)
end
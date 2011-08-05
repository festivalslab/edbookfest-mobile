When /^I click on author (\d+)$/ do |index|
  find(event_detail_selector_for("author #{index}")).find('a').click
end

When /^I click on book (\d+)$/ do |index|
  find(event_detail_selector_for("book #{index}")).find('a').click
end

Then /^the event title should be "([^\"]*)"$/ do |title|
  page.should have_css(event_detail_selector_for("title"), :text => title)
end

Then /^the event subtitle should be "([^\"]*)"$/ do |sub_title|
  page.should have_css(event_detail_selector_for("subtitle"), :text => sub_title)
end

Then /^the event title sponsors should be "([^\"]*)"$/ do |text|
  page.should have_css(event_detail_selector_for("title sponsors"), :text => text)
end

Then /^the event time should be "([^\"]*)"$/ do |time|
  page.should have_css(event_detail_selector_for("time"), :text => time)
end

Then /^the event duration should be "([^\"]*)"$/ do |duration|
  page.find(event_detail_selector_for("duration")).should have_content duration
end

Then /^the event venue should be "([^\"]*)"$/ do |venue|
  page.should have_css(event_detail_selector_for("venue"), :text => venue)
end

Then /^the event standfirst should be "([^\"]*)"$/ do |standfirst|
  page.should have_css(event_detail_selector_for("standfirst"), :text => standfirst)
end

Then /^the event description should be "([^\"]*)"$/ do |description|
  page.should have_css(event_detail_selector_for("description"), :text => description)
end

Then /^the event price should be "([^\"]*)"$/ do |price|
  page.find(event_detail_selector_for("price")).should have_content price
end

Then /^the event image should be "([^\"]*)" with alt text "([^\"]*)"$/ do |image_url, image_alt|
  image = page.find(event_detail_selector_for("image"))
  image["src"].should eq(image_url)
  image["alt"].should eq(image_alt)
end

Then /^the event theme should be "([^\"]*)"$/ do |theme|
  page.should have_css(event_detail_selector_for("theme"), :text => theme)
end

Then /^the event buy tickets button should be "([^\"]*)"$/ do |url|
  href = page.find(event_detail_selector_for("buy tickets button"))["href"]
  href.should eq(url)
end

Then /^the event (.*) is missing$/ do |element|
  page.should_not have_css(event_detail_selector_for(element))
end

Then /^the event is sold out$/ do
  page.should have_css('.sold-out', :text => 'Sold out')
end

Then /^the event should have (\d+) authors$/ do |author_count|
  page.should have_css('ul.authors li', :count => author_count)
end

Then /^the event should not have authors$/ do
  page.should_not have_css('ul.authors')
end

Then /^event author (\d+) should be "(\w+) (\w+)"$/ do |index, first_name, last_name|
  author = find(event_detail_selector_for("author #{index}"))
  author.should have_content("#{first_name} #{last_name}")
end

Then /^I should be on the author detail page for author (\d+)$/ do |index|
  current_path = URI.parse(current_url).path
  current_path.should == path_to("the author detail page for #{index}")
end

Then /^the event should have (\d+) books?$/ do |book_count|
  page.should have_css('ul.amazon-books li', :count => book_count)
end

Then /^event book (\d+) (.*) should be "([^\"]*)"$/ do |index, field, text|
  book = find(event_detail_selector_for("book #{index}"))
  book.should have_css(book_item_selector_for(field), :text => text)
end

Then /^event book (\d+) (.*) should have source of "([^\"]*)"$/ do |index, field, src|
  book = find(event_detail_selector_for("book #{index}"))
  book.should have_css(book_item_selector_for(field), :src => src)
end

Then /^event book (\d+) should be in stock$/ do |index|
  book = find(event_detail_selector_for("book #{index}"))
  book.should have_content "in stock"
end

Then /^event book (\d+) should not be in stock$/ do |index|
  book = find(event_detail_selector_for("book #{index}"))
  book.should_not have_content "in stock"
end

Then /^the event should not have books$/ do
  page.should_not have_css('ul.amazon-books')
end

Then /^I should be on the book detail page for book (\d+)$/ do |index|
  current_path = URI.parse(current_url).path
  current_path.should == path_to("the book detail page for #{index}")
end

Then /^event book (\d+) image is "([^\"]*)"$/ do |index, image_url|
  book = page.find(event_detail_selector_for("book #{index}"))
  book.find('img')['src'].should == image_url
end

Then /^event book (\d+) image is not present$/ do |index|
  book = page.find(event_detail_selector_for("book #{index}"))
  book.should_not have_css('img')
end
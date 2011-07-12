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
Then /^the event title should be "([^\"]*)"$/ do |title|
  page.should have_css("h3", :text => title)
end

Then /^the event subtitle should be "([^\"]*)"$/ do |sub_title|
  page.should have_css("h4", :text => sub_title)
end

Then /^the event title sponsors should be "([^\"]*)"$/ do |text|
  page.should have_css("h5.title-sponsors", :text => text)
end

Then /^the event start time should be "([^\"]*)"$/ do |time|
  page.should have_css("time", :text => time)
end

Then /^the event duration should be "([^\"]*)"$/ do |duration|
  page.should have_css(".duration", :text => duration)
end

Then /^the event venue should be "([^\"]*)"$/ do |venue|
  page.should have_css(".venue", :text => venue)
end

Then /^the event standfirst should be "([^\"]*)"$/ do |standfirst|
  page.should have_css(".standfirst", :text => standfirst)
end

Then /^the event description should be "([^\"]*)"$/ do |description|
  page.should have_css(".description", :text => description)
end

Then /^the event price should be "([^\"]*)"$/ do |price|
  page.should have_css(".price", :text => price)
end

Then /^the event image should be "([^\"]*)"$/ do |image_url|
  image = page.find("img.event")
  image["src"].should eq(image_url)
end

Then /^the event theme should be "([^\"]*)"$/ do |theme|
  page.should have_css(".theme", :text => theme)
end
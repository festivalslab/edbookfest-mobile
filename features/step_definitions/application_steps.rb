Given /^today is (.+)$/ do |date|
  Delorean.time_travel_to(date)
end

Then /^the title should be "([^"]*)"$/ do |text|
  page.should have_css("h2", :text => text)
end

Then /^the theme should be "([^"]*)"$/ do |theme|
  page.should have_css("body.#{theme}")
end

Then /^the page heading should be "([^"]*)"$/ do |text|
  page.should have_css("h3", :text => text)
end

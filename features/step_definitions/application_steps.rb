Given /^today is (.+)$/ do |date|
  Delorean.time_travel_to(date)
end

Then /^the theme should be "([^"]*)"$/ do |theme|
  page.should have_css("body.#{theme}")
end

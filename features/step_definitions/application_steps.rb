Given /^today is (\d{2}\/\d{2}\/\d{4})$/ do |date|
  Delorean.time_travel_to(date)
end

Given /^today is (\d{2}\/\d{2}\/\d{4}) and the time is (\d{2}:\d{2})$/ do |date, time|
  date_time = DateTime.strptime("#{date} #{time}+0100", "%d/%m/%Y %H:%M%z")
  Delorean.time_travel_to date_time
end

When /^I wait until "([^\"]*)" (?:are|is) visible$/ do |className|
  page.has_css?(".#{className}", :visible => true)
end

When /^I click the back button$/ do
  page.find('a.back').click
end

Then /^the title should be "([^\"]*)"$/ do |text|
  title = page.find(:xpath, "//title").text
  title.should =~ /#{text}/
end

Then /^the section title should be "([^\"]*)"$/ do |text|
  page.should have_css("h2", :text => text)
end

Then /^the theme should be "([^\"]*)"$/ do |theme|
  page.should have_css("body.#{theme}")
end

Then /^the page heading should be "([^\"]*)"$/ do |text|
  page.should have_css("h3", :text => text)
end

Then /^I should be on the (\w+) page$/ do |page|
  current_path = URI.parse(current_url).path
  current_path.should == path_to("the #{page} page")
end

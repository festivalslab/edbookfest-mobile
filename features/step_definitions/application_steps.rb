Given /^today is (\d{2}\/\d{2}\/\d{4})$/ do |date|
  Delorean.time_travel_to(date)
end

Given /^today is (\d{2}\/\d{2}\/\d{4}) and the time is (\d{2}:\d{2})$/ do |date, time|
  date_time = DateTime.strptime("#{date} #{time}+0100", "%d/%m/%Y %H:%M%z")
  Delorean.time_travel_to date_time
end

Given /^the festival dates are (\d{2}\/\d{2}\/\d{4}) - (\d{2}\/\d{2}\/\d{4})$/ do |from, to|
  Setting.festival_start_date = DateTime.strptime(from, "%d/%m/%Y").to_s
  Setting.festival_end_date = DateTime.strptime(to, "%d/%m/%Y").to_s
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

Then /^I should be on the (\w+|coming soon|dates settings) page$/ do |page|
  current_path = URI.parse(current_url).path
  current_path.should == path_to("the #{page} page")
end

Then /^I wait until I am on the (\w+) page$/ do |page|
  wait_until() do
    current_path = URI.parse(current_url).path
    current_path == path_to("the #{page} page")
  end
end

Given /^I authenticate with HTTP basic authentication$/ do
  if page.driver.respond_to?(:basic_auth)
    page.driver.basic_auth(ENV["HTTP_USERNAME"], ENV["HTTP_PASSWORD"])
  elsif page.driver.respond_to?(:basic_authorize)
    page.driver.basic_authorize(ENV["HTTP_USERNAME"], ENV["HTTP_PASSWORD"])
  elsif page.driver.respond_to?(:browser) && page.driver.browser.respond_to?(:basic_authorize)
    page.driver.browser.basic_authorize(ENV["HTTP_USERNAME"], ENV["HTTP_PASSWORD"])
  else
    raise "I don't know how to log in!"
  end
end

Then /^I should be asked to authenticate for the "([^\"]+)" realm$/ do |realm|
  page.status_code.should == 401
  page.response_headers["WWW-Authenticate"].should == "Basic realm=\"#{realm}\""
end
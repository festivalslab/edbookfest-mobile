Then /^there should be (\d+) days in the calendar$/ do |days|
  calendar = find('#calendar')
  all_days = calendar.all("td:not(.otherMonth)")
  all_days.length.should == days.to_i
end

Then /^there should be a date link on the (\d+)(?:th|st|nd|rd)$/ do |day|
  calendar = find('#calendar')
  calendar.should have_css("td a", :text => day)
end

Then /^there should not be a date link on the (\d+)(?:th|st|nd|rd)$/ do |day|
  calendar = find('#calendar')
  calendar.should_not have_css("td a", :text => day)
end

Then /^there should be (\d+) date links$/ do |no_of_date_links|
  date_links = all('#calendar td a')
  date_links.length.should == no_of_date_links.to_i
end

Then /^the (\d+)(?:th|st|nd|rd) should be highlighted$/ do |day|
  calendar = find('#calendar')
  calendar.should have_css("td.today a", :text => day)
end
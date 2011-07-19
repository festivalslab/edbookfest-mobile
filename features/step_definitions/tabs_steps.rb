When /^I click the (.*) tab$/ do |tab_text|
  tab = find("ul.tabs li a", :text => tab_text)
  tab.click
end

Then /^the (.*) tab should (not)?\s?be highlighted$/ do |tab_text, inv|
  active_tab = find("ul.tabs li.active a")
  if (inv) then
    active_tab.text.should_not == tab_text
  else
    active_tab.text.should == tab_text
  end
end

Then /^I should see (\d+) tabs$/ do |tab_count|
  page.should have_css('ul.tabs li', :count => tab_count)
end

Then /^tab (\d+) should be "([^\"]*)"$/ do |tab_index, label|
  page.should have_css("ul.tabs li:nth-child(#{tab_index})", :content => label)
end

Then /^tab (\d+) is highlighted$/ do |tab_index|
  page.find("ul.tabs li:nth-child(#{tab_index})")["class"].should =~ /\bactive\b/
end
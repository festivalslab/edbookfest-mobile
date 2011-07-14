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
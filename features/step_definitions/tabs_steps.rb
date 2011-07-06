When /^I click the (.*) tab$/ do |tab_text|
  tab = find(".tabs li", :text => tab_text.upcase)
  tab.click
end

Then /^the (.*) tab should (not)?\s?be highlighted$/ do |tab_text, inv|
  active_tab = find(".tabs li.active")
  if (inv) then
    active_tab.text.should_not == tab_text.upcase
  else
    active_tab.text.should == tab_text.upcase
  end
end

Then /^the (.*) tab section should (not)?\s?be visible$/ do |tab_text, inv|
  all_tabs = all(".tabs li").map &:text
  tab = find(".tabs li", :text => tab_text.upcase)
  index = all_tabs.index(tab.text)
  section = all('.tabs-container .tab-content')[index]
  if (inv) then
    section.should_not be_visible
  else
    section.should be_visible
  end
end
Then /^I should see (\d+) articles$/ do |count|
  page.should have_css('ul.articles li', :count => count)
end
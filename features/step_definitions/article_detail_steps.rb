Then /^the article publication date should have a value of "([^\"]*)"$/ do |date|
  time = find article_selector_for("publication date")
  time['datetime'].should == date
end

Then /^the article link should have a url of "([^\"]*)"$/ do |url|
  link = find article_selector_for("link")
  link['href'].should == url
end

Then /^the article body should contain "([^\"]*)"$/ do |text|
  page.should have_css article_selector_for("body"), :content => /#{text}/
end

Then /^the article (.+) should be "([^\"]*)"$/ do |field, text|
  page.should have_css article_selector_for(field), :text => text
end

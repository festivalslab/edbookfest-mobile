Given /^the article search returns good results$/ do
  stub_guardian_request("search", "guardian_valid_search.json")
end

When /^I click on article (\d+)$/ do |index|
  find(selector_for("article #{index}")).find('a').click
end

Then /^I should see (at least )?(\d+) articles?$/ do |at_least, count|
  articles = page.all('ul.articles li')
  if at_least then
    articles.count.should >= count.to_i
  else
    articles.count.should == count.to_i
  end
end

Then /^article (\d+) should have a title$/ do |index|
  page.should have_css(selector_for("article #{index}"), :content => /.+/)
end

Then /^article (\d+) should have a date$/ do |index|
  date = find selector_for("article #{index} date")
  date['datetime'].should =~ /\d{4}-\d{2}-\d{2}.\d{2}:\d{2}:\d{2}\s?\+01:?00/
end

Then /^article (\d+) should have date text$/ do |index|
  page.should have_css selector_for("article #{index} date"), :content => /\d{1,2} \w+ \d{4}/
end

Then /^article (\d+) should link to an article$/ do |index|
  link = find selector_for("article #{index} link")
  link['href'].should =~ /authors\/\d+\/articles\/.+$/
end

Then /^I should be on the "(\w+) (\w+)" author article detail page for "([^\"]*)"$/ do |first_name, last_name, article_id|
  current_path = URI.parse(current_url).path
  current_path.should == path_to("the \"#{first_name} #{last_name}\" author article detail page for #{article_id}")
end

Then /^I should see the Powered by Guardian logo$/ do
  page.should have_css('img.powered-by-guardian')
end
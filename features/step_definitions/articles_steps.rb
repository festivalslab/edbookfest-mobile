Given /^the article search returns good results$/ do
  stub_guardian_request("search", "guardian_valid_search.json")
end

Then /^I should see (at least )?(\d+) articles?$/ do |at_least, count|
  articles = page.all('ul.articles li')
  if at_least then
    articles.count.should >= count.to_i
  else
    articles.count.should == count.to_i
  end
end

Then /^article (\d+) title should be "([^\"]*)"$/ do |index, title_text|
  article = find selector_for("article #{index}")
  article.should have_content title_text
end

Then /^article (\d+) date should de "([^\"]*)"$/ do |index, date_text|
  date = find selector_for("article #{index} date")
  date.should have_content date_text
end
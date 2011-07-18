Then /^I should see (at least )?(\d+) articles?$/ do |at_least, count|
  articles = page.all('ul.articles li')
  if at_least then
    articles.count.should >= count.to_i
  else
    articles.count.should == count.to_i
  end
end
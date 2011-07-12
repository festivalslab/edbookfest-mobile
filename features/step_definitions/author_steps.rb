Given /^there are (\d+) authors appearing at the "([^\"]*)" event$/ do |author_count, event_title|
  event = Factory.build(:event, :title => event_title)
  authors = []
  author_count.to_i.times do |i|
    authors.push Factory.build(:author, :first_name => "First#{i}", :last_name => "Last#{i}")
  end
  author_count.to_i.times do |i|
    appearance = Factory.create(:appearance, :event => event, :author => authors[i])
  end
end
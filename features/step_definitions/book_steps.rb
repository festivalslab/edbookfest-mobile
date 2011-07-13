Given /^there are (\d+) books featured at the "([^\"]*)" event$/ do |book_count, event_title|
  event = Factory.build(:event, :title => event_title)
  books = []
  book_count.to_i.times do |i|
    books.push Factory.build(:book)
  end
  book_count.to_i.times do |i|
    featured_book = Factory.create(:featured_book, :event => event, :book => books[i])
  end
  event.save
end
Factory.define :featured_book do |featured_book|
  featured_book.association :event
  featured_book.association :book
end
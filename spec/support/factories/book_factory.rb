Factory.define :book do |f|
  f.sequence(:eibf_id) {|n| n }
  f.sequence(:title) {|n| "Book Title #{n}" }
  f.sequence(:amazon_url) {|n| "http://book.link/#{n}" }
  f.sequence(:isbn) {|n| "1234#{n}" }
  f.sequence(:amazon_image) {|n| "http://book.image/#{n}.jpg" }
end
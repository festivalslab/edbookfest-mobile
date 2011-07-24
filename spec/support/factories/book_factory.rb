Factory.define :book do |f|
  f.sequence(:eibf_id) {|n| n }
  f.sequence(:title) {|n| "Book Title #{n}" }
  f.sequence(:amazon_url) {|n| "http://book.link/#{n}" }
  f.sequence(:isbn) {|n| "9781409103479" }
  f.amazon_image "http://book.image/image.jpg"
end
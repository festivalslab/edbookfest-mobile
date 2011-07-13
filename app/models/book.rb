class Book < ActiveRecord::Base
  has_many :featured_books
  has_many :events, :through => :featured_books, :uniq => true
end

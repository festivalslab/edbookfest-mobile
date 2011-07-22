class Book < ActiveRecord::Base
  has_many :featured_books
  has_many :events, :through => :featured_books, :uniq => true
  
  def self.without_events
    includes(:featured_books).where( :featured_books => { :event_id => nil } )
  end
  
  def to_param
    "#{eibf_id}-#{title.parameterize}"
  end
end

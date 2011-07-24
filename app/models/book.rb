class Book < ActiveRecord::Base
  has_many :featured_books
  has_many :events, :through => :featured_books, :uniq => true
  validates_length_of :isbn, :is => 13
  
  def self.without_events
    includes(:featured_books).where( :featured_books => { :event_id => nil } )
  end
  
  def to_param
    "#{eibf_id}-#{title.parameterize}"
  end
  
  def amazon_lookup
    request = Sucker.new
    request << {
      'Operation' => 'ItemLookup',
      'IdType' => 'EAN',
      'ItemId' => isbn.to_s,
      'ResponseGroup' => 'Images,ItemAttributes,EditorialReview',
      'SearchIndex' => 'Books'
    }
    AmazonBook.new(request.get)
  end
end

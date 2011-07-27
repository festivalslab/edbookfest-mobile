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
    response = make_sucker_request(
      'Operation' => 'ItemLookup', 
      'IdType' => 'EAN',
      'ItemId' => isbn.to_s,
      'ResponseGroup' => 'Images,ItemAttributes,EditorialReview,AlternateVersions',
      'SearchIndex' => 'Books')
    (response.has_errors?) ? nil : AmazonBook.new(response)
  end
  
  def kindle_lookup(asin)
    response = make_sucker_request(
      'Operation' => 'ItemLookup',
      'IdType' => 'ASIN',
      'ItemId' => asin,
      'ResponseGroup' => 'ItemAttributes')
    (response.has_errors?) ? nil : AmazonBook.new(response)
  end
  
private

  def make_sucker_request(options)
    request = Sucker.new
    request << options
    request.get
  end
  
end

module HTTParty
  class Parser
    def json
      MultiJson.decode(body)
    end
  end
end

class Book < ActiveRecord::Base
  include HTTParty
  base_uri 'itunes.apple.com'
  default_params :country => 'gb'
  
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
    sucker_request(
      'Operation' => 'ItemLookup', 
      'IdType' => 'EAN',
      'ItemId' => isbn.to_s,
      'ResponseGroup' => 'Images,ItemAttributes,EditorialReview,AlternateVersions',
      'SearchIndex' => 'Books')
  end
  
  def kindle_lookup(asin)
    sucker_request(
      'Operation' => 'ItemLookup',
      'IdType' => 'ASIN',
      'ItemId' => asin,
      'ResponseGroup' => 'ItemAttributes')
  end
  
  def itunes_lookup
    res = self.class.get '/lookup', :query => { :isbn => isbn.to_s }
    (res && res['results'] && res['results'][0]) ? res['results'][0]['trackViewUrl'] : nil
  end
  
private

  def sucker_request(options)
    request = Sucker.new
    request << options
    response = request.get
    (response.has_errors?) ? nil : AmazonBook.new(response)
  end
  
end

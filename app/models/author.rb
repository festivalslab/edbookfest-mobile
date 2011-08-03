class Author < ActiveRecord::Base
  has_many :appearances
  has_many :events, :through => :appearances, :uniq => true
  
  def self.without_events
    includes(:appearances).where( :appearances => { :event_id => nil } )
  end
  
  def to_param
    "#{eibf_id}-#{full_name.parameterize}"
  end
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def bibliography
    books = []
    response = amazon_search
    unless response.has_errors?
      response['Item'].each { |item| books << AmazonBook.new(item) } 
    end
    books
  end
  
  def amazon_search_link
    "http://www.amazon.co.uk/gp/search?index=books&keywords=#{CGI::escape(full_name)}&ie=UTF8&tag=#{ENV['EIBF_AMAZON_TRACKING_ID']}"
  end
  
private

  def amazon_search
    power = "author-exact:#{full_name} and not binding:Kindle Edition"
    request = Sucker.new
    request << { 
      'Operation' => 'ItemSearch', 
      'SearchIndex' => 'Books',
      'Power' => power,
      'ResponseGroup' => 'ItemAttributes,ItemIds,Images',
      'Sort' => 'salesrank',
      'MerchantId' => 'Amazon',
      'Condition' => 'New'
    }
    request.get
  end
  
end

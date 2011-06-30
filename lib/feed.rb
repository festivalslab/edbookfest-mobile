require 'nokogiri'

class Feed
  
  def self.load_url(uri)
    Nokogiri::XML(open(uri))
  end
  
end
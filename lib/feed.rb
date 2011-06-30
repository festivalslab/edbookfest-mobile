require 'nokogiri'
require 'open-uri'

class Feed
  
  def load_url(url)
    @doc = Nokogiri::XML(open(url))
  end
  
  def update()
    @doc.css('Event').each do |event|
      Event.create()
    end
  end
  
end
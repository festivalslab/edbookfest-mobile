require 'nokogiri'
require 'open-uri'

module Feed
  
  class Stock
    
    def initialize(url)
      @url = url
    end
    
    # Loads feed file
    def load_file(output = true)
      file = open(@url)
      puts "Feed source loaded successfully" if output
      file
    end
    
  end
  
end
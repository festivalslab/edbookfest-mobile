require 'nokogiri'
require 'open-uri'

module Feed
  
  class Stock
    
    def initialize(url)
      @url = url
    end
    
    def load(output = true)
      @doc = Nokogiri::XML load_file(output) do |config|
        config.sax1
      end
      puts "Feed source has #{@doc.css('book').size} books" if output
    end
    
    # Loads feed file
    def load_file(output = true)
      file = open(@url)
      puts "Feed source loaded successfully" if output
      file
    end
    
    def update(output = true)
      @doc.css('book').each { |book| update_book(book) }
      puts "Stock import completed." if output
      puts "There are now #{Book.all.count} books in the database." if output
    end
    
  private
    
    def update_book(book)
      isbn = book['isbn13']
      b = Book.find_or_initialize_by_isbn isbn
      b.update_attributes(book_attributes(book, b))
    end
    
    def book_attributes(book, book_model)
      attrs = { :stock_status => book.at_css('stock').text }
      attrs[:title] = book.at_css('title').text unless book_model.title
      attrs
    end
    
  end
  
end
require 'spec_helper'

describe Feed::Stock do
  
  let(:stock_file) { open(Rails.root + 'spec/support/stock.xml') } 
  let(:doc) { Nokogiri::XML(stock_file) }
  let(:url) { "http://foo.bar/woo" }

  describe "#load_url" do
    before(:each) do
      Nokogiri::XML::Document.stub!(:parse).and_return(:doc)
    end
    
    it "calls open" do
      stock = Feed::Stock.new url
      stock.stub!(:open)
      stock.should_receive(:open).with(url)
      stock.load false
    end

    it "creates a Nokogiri XML doc" do
      stock = Feed::Stock.new url
      stock.stub!(:open)
      Nokogiri::XML::Document.should_receive(:parse)
      stock.load false
    end
  end
  
  describe "#update" do
    let(:stock) { Feed::Stock.new(url) }
    let(:expected_count) { 6 } 
  
    before(:each) do
      stock.stub!(:open).and_return(stock_file)
      stock.load false
    end
    
    context "when there are no existing books" do
      it "creates the correct number of books" do
        stock.update false
        Book.all.count.should == expected_count
      end
      
      it "does not create duplicates" do
        stock.update false
        stock.update false
        Book.all.count.should == expected_count
      end
      
      it "creates the correct data for a book" do
        stock.update false
        b = Book.find_by_isbn("9780199119943")
        b.title.should == "Oxford Illustrated Children's Thesaurus: 2010"
        b.stock_status.should == "available"
      end
    end
    
    context "updating existing books" do
      it "updates an existing book but does not overwrite the title" do
        Factory.create(:book, :isbn => "9780199119943", :title => "My original title", :stock_status => "none")
        Book.all.count.should == 1
        stock.update false
        Book.all.count.should == expected_count
        book = Book.find_by_isbn("9780199119943")
        book.title.should == "My original title"
        book.stock_status.should == "available"
      end
    end
  end
end

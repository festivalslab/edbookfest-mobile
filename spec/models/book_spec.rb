# encoding: UTF-8

require 'spec_helper'

describe Book do
  before(:each) do
    @book = Book.new :isbn => "9780099548973"
  end
  
  describe "Event has_many_through association" do
    it "allows a book association" do
      @book.events.build
      @book.should have(:no).errors_on(:events)
    end
  end
  
  describe "#without_events" do
    it "does not select a book that still has events" do
      @book.events.build
      @book.save
      Book.without_events.should have_exactly(0).items
    end
    
    it "selects a book that has no events" do
      @book.save
      Book.without_events.should have_exactly(1).items
    end
  end
  
  describe "#to_param" do
    it "creates an id out of eibf_id and title" do
      @book.eibf_id = 1234
      @book.title = "Book Title With non-iso ChåractÉrs"
      @book.to_param.should == "1234-book-title-with-non-iso-characters"
    end
  end
  
  describe "#amazon_lookup" do
    use_vcr_cassette "Amazon Lookup"
    
    let(:amazon_book) { double("AmazonBook") } 
    
    it "returns an AmazonBook" do
      AmazonBook.should_receive(:new)
      b = @book.amazon_lookup
    end
    
  end
end

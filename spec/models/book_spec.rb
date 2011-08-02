# encoding: UTF-8

require 'spec_helper'

describe Book do
  
  context "valid isbn" do
    before(:each) do
      @book = Book.new :isbn => "9780099548973"
      @book_with_itunes = Book.new :isbn => "9781846142147"
      @book_wihout_itunes = Book.new :isbn => "9780689837593"
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
      it "uses isbn as the id" do
        @book.isbn = "9780001234567890"
        @book.to_param.should == "9780001234567890"
      end
    end

    describe "#amazon_lookup" do
      use_vcr_cassette "amazon lookup"

      let(:amazon_book) { double("AmazonBook") } 

      it "returns an AmazonBook" do
        AmazonBook.should_receive(:new)
        b = @book.amazon_lookup
      end
    end
    
    describe "#kindle_lookup" do
      use_vcr_cassette "kindle lookup"
      
      let(:amazon_book) { double("AmazonBook") }
      
      it "returns an AmazonBook" do
        AmazonBook.should_receive(:new)
        b = @book.kindle_lookup "B002S0KB4U"
      end
    end
    
    describe "#itunes_lookup" do
      use_vcr_cassette "itunes lookup"
      
      it "returns the itunes item link" do
        @book_with_itunes.itunes_lookup.should == "http://itunes.apple.com/gb/book/india/id419753457?mt=11&uo=4"
      end
      
      it "returns nil for a book that has no itunes edition" do
        @book_wihout_itunes.itunes_lookup.should be_nil
      end
    end
    
    describe "#in_stock?" do
      context "when book is available" do
        before(:each) do
          @book.stock_status = "available"
        end
        
        it "is in stock" do
          @book.in_stock?.should be_true
        end
      end
      
      context "when book has limited availability" do
        before(:each) do
          @book.stock_status = "limited"
        end
        
        it "is in stock" do
          @book.in_stock?.should be_true
        end
      end
      
      context "when book has no availability" do
        before(:each) do
          @book.stock_status = "none"
        end
        
        it "is not in stock" do
          @book.in_stock?.should be_false
        end
      end
      
      context "when stock_status is nil" do
        it "is not in stock" do
          @book.in_stock?.should be_false
        end
      end
    end
  end
  
  context "invalid isbn" do
    before(:each) do
      @book = Book.new :isbn => "9780000000000"
    end
    
    describe "#amazon_lookup" do
      use_vcr_cassette "Amazon Lookup"
      
      let(:amazon_book) { double("AmazonBook") } 
      
      it "returns nil" do
        @book.amazon_lookup.should be_nil
      end
    end
  end
  
end

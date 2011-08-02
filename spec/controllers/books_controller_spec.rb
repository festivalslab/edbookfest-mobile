require 'spec_helper'

describe BooksController do
  describe "GET 'show'" do
    let(:book) { mock_model(Book).as_null_object }
    let(:amazon_book) { double "AmazonBook" }
    
    context "when book model is present" do
      before(:each) do
        Book.stub(:find_by_isbn).and_return book
        book.stub(:amazon_lookup).and_return amazon_book
        amazon_book.stub(:kindle_asin).and_return "ABC123"
        book.stub(:isbn).and_return "9780001234567890"
      end

      it "should be successful" do
        get :show, :id => "9780001234567890"
        response.should be_success
      end
      
      it "sets the cache headers to an hour" do
        get :show, :id => "9780001234567890"
        response.headers['Cache-Control'].should == 'public, max-age=3600'
      end

      it "assigns book" do
        Book.should_receive(:find_by_isbn).with("9780001234567890")
        get :show, :id => "9780001234567890"
        assigns[:book].should eq(book)
      end

      it "assigns @title" do
        book.stub(:title).and_return("Book Title")
        get :show, :id => "9780001234567890"
        assigns[:title].should == "Book Title"
      end

      it "assigns @section" do
        get :show, :id => "9780001234567890"
        assigns[:section].should == "Books"
      end

      it "assigns @theme" do
        get :show, :id => "9780001234567890"
        assigns[:theme].should == "books"
      end

      it "performs an amazon lookup" do
        book.should_receive(:amazon_lookup)
        get :show, :id => "9780001234567890"
        assigns[:amazon_book].should == amazon_book
      end
    end
    
    context "when there is a kindle edition" do
      let(:kindle_book) { double "AmazonBook" }
      
      before(:each) do
        Book.stub(:find_by_isbn).and_return book
        book.stub(:isbn).and_return "9780001234567890"
        book.stub(:amazon_lookup).and_return amazon_book
        amazon_book.stub(:kindle_asin).and_return "ABC123"
        book.stub(:kindle_lookup).and_return kindle_book
      end
      
      it "performs a kindle lookup" do
        book.should_receive(:kindle_lookup).with("ABC123")
        get :show, :id => "9780001234567890"
        assigns[:kindle_book].should == kindle_book
      end
    end
    
    context "when there is no kindle edition" do
      before(:each) do
        Book.stub(:find_by_isbn).and_return book
        book.stub(:isbn).and_return "9780001234567890"
        book.stub(:amazon_lookup).and_return amazon_book
        amazon_book.stub(:kindle_asin).and_return nil
      end
      
      it "does not perform a kindle lookup" do
        get :show, :id => "9780001234567890"
        assigns[:kindle_book].should be_nil
      end
    end
    
    context "when there is an itunes edition" do
      before(:each) do
        Book.stub(:find_by_isbn).and_return book
        book.stub(:isbn).and_return "9780001234567890"
        book.stub(:amazon_lookup).and_return amazon_book
        book.stub(:itunes_lookup).and_return "http://itunes.apple.com/some/item"
        amazon_book.stub(:kindle_asin).and_return nil
        
      end
      
      it "performs an itunes lookup" do
        book.should_receive :itunes_lookup
        get :show, :id => "9780001234567890"
        assigns[:itunes_link].should == "http://itunes.apple.com/some/item"
      end
    end

  end
end

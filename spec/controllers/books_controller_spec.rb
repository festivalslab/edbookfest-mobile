require 'spec_helper'

describe BooksController do
  describe "GET 'show'" do
    let(:book) { mock_model(Book).as_null_object }
    let(:amazon_details) { {"foo" => "bar"} }
    
    before(:each) do
      Book.stub(:find_by_eibf_id).and_return book
      book.stub(:amazon_lookup).and_return(amazon_details)
    end
    
    context "when isbn is present" do
      before(:each) do
        book.stub(:isbn).and_return("9780001234567890")
      end

      it "should be successful" do
        get :show, :id => "1234-book-title"
        response.should be_success
      end

      it "assigns book" do
        Book.should_receive(:find_by_eibf_id).with("1234-book-title")
        get :show, :id => "1234-book-title"
        assigns[:book].should eq(book)
      end

      it "assigns @title" do
        book.stub(:title).and_return("Book Title")
        get :show, :id => "1234-book-title"
        assigns[:title].should == "Book Title"
      end

      it "assigns @section" do
        get :show, :id => "1234-book-title"
        assigns[:section].should == "Books"
      end

      it "assigns @theme" do
        get :show, :id => "1234-book-title"
        assigns[:theme].should == "books"
      end

      it "performs an amazon lookup" do
        book.should_receive(:amazon_lookup)
        get :show, :id => "1234-book-title"
        assigns[:amazon_book].should == amazon_details
      end
    end
    
    context "when isbn is empty" do
      before(:each) do
        book.stub(:isbn).and_return ""
      end
      
      it "404s" do
        lambda {
          get :show, :id => "1234-book-title"
        }.should raise_exception(ActionController::RoutingError)
      end
    end

  end
end

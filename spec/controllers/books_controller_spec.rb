require 'spec_helper'

describe BooksController do
  describe "GET 'show'" do
    let(:attributes) { {"title" => "Book Title"} } 
    
    before(:each) do
      Book.stub(:find).and_return attributes
    end
    
    it "should be successful" do
      get :show, :id => 1
      response.should be_success
    end
  end
end

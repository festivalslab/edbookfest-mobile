require 'spec_helper'

describe AuthorsController do  
  describe "GET 'show'" do
    let(:attributes) { {"first_name" => "Joe", "last_name" => "Bloggs"} } 
    
    before(:each) do
      Author.stub(:find).and_return attributes
    end
    
    it "should be successful" do
      get :show, :id => 1
      response.should be_success
    end
  end
end

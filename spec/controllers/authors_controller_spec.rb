require 'spec_helper'

describe AuthorsController do
  
  describe "GET 'show'" do
    let(:expected_theme) { "authors" }
    let(:expected_section) { "Authors" }  
    let(:author) { mock_model(Author).as_null_object } 
    
    before(:each) do
      Author.stub(:find_by_eibf_id).and_return author
    end
    
    it "should be successful" do
      get :show, :id => "1234-first-last"
      response.should be_success
    end
    
    it "assigns @theme" do
      get :show, :id => "1234-first-last"
      assigns[:theme].should eq(expected_theme)
    end
    
    it "assigns @section" do
      get :show, :id => "1234-first-last"
      assigns[:section].should eq(expected_section)
    end
    
    it "assigns @author" do
      Author.should_receive(:find_by_eibf_id).with("1234-first-last")
      get :show, :id => "1234-first-last"
      assigns[:author].should eq(author)
    end
    
    it "assigns @title" do
      author.stub(:full_name).and_return("Joe Bloggs")
      get :show, :id => "1234-first-last"
      assigns[:title].should eq("Joe Bloggs")
    end
    
    describe "setting layout" do
      it "uses the application layout for normal requests" do
        get :show, :id => "1234-first-last"
        response.should render_template("layouts/application")
      end

      it "uses no layout for PJAX requests" do
        request.env['X-PJAX'] = 'true'
        get :show, :id => "1234-first-last"
        response.should_not render_template("layouts/application")
      end
    end
  end
end

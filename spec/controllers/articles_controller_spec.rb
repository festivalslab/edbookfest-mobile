# encoding: utf-8
require 'spec_helper'

describe ArticlesController do
  
  let(:author) { mock_model(Author).as_null_object }
  
  before(:each) do
    Author.stub(:find).and_return author
  end

  describe "GET 'index'" do
    it "assigns author" do
      Author.should_receive(:find).with(1)
      get :index, :author_id => 1
      assigns[:author].should eq(author)
    end
    
    it "assigns title" do
      author.stub(:full_name).and_return("Joe Bloggs")
      get 'index', :author_id => 1
      assigns[:title].should == "Joe Bloggs – Guardian articles"
    end
    
    it "assigns section" do
      get 'index', :author_id => 1
      assigns[:section].should == "Authors"
    end
    
    it "assigns theme" do
      get 'index', :author_id => 1
      assigns[:theme].should == "authors"
    end
    
    it "assigns articles" do
      get 'index', :author_id => 1
      assigns[:articles].length.should == 10
    end
    
    describe "setting layout" do
      it "uses the application layout for normal requests" do
        get :index, :author_id => 1
        response.should render_template("layouts/application")
      end

      it "uses no layout for PJAX requests" do
        request.env['X-PJAX'] = 'true'
        get :index, :author_id => 1
        response.should_not render_template("layouts/application")
      end
    end
  end

end

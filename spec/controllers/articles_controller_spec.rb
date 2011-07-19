# encoding: utf-8
require 'spec_helper'

describe ArticlesController do
  
  let(:author) { mock_model(Author).as_null_object }
  
  before(:each) do
    Author.stub(:find).and_return author
    author.stub(:full_name).and_return("Joe Bloggs")
  end

  describe "GET 'index'" do
    before(:each) do
      Article.stub(:search).and_return(["1","2"])
    end
    
    it "assigns author" do
      Author.should_receive(:find).with(1)
      get :index, :author_id => 1
      assigns[:author].should eq(author)
    end
    
    it "assigns title" do
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
    
    context "when there are results" do      
      it "assigns articles" do
        Article.should_receive(:search).with("Joe Bloggs")
        get 'index', :author_id => 1
        assigns[:articles].length.should == 2
      end 
    end
    
    context "when there are no results" do
      before(:each) do
        Article.stub(:search).and_return([])
      end
      
      it "assigns articles" do
        Article.should_receive(:search).with("Joe Bloggs")
        get 'index', :author_id => 1
        assigns[:articles].length.should == 0
      end
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
  
  describe "GET 'show'" do
    let(:article) { { "fields" => { "headline" => "Article title" }} }
    
    before(:each) do
      Article.stub(:find).and_return(article)
    end
    
    it "succeeds" do
      get :show, :author_id => 1, :id => 'foo/bar'
      response.should be_success
    end
    
    it "assigns author" do
      Author.should_receive(:find).with(1)
      get :show, :author_id => 1, :id => 'foo/bar'
      assigns[:author].should eq(author)
    end
    
    it "assigns article" do
      Article.should_receive(:find).with('foo/bar')
      get :show, :author_id => 1, :id => 'foo/bar'
      assigns[:article].should eq(article)
    end
    
    it "assigns title" do
      get 'show', :author_id => 1, :id => 'foo/bar'
      assigns[:title].should == "Article title"
    end
  end

end

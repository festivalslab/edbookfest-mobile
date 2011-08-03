# encoding: utf-8
require 'spec_helper'

describe ArticlesController do
  
  let(:author) { mock_model(Author).as_null_object }
  
  before(:each) do
    Author.stub(:find_by_eibf_id).and_return author
    author.stub(:full_name).and_return("Joe Bloggs")
  end

  describe "GET 'index'" do
    before(:each) do
      Article.stub(:search).and_return(["1","2"])
    end
    
    it "sets the cache headers to an hour" do
      get :index, :author_id => "1234-joe-bloggs"
      response.headers['Cache-Control'].should == 'public, max-age=3600'
    end
    
    it "assigns author" do
      Author.should_receive(:find_by_eibf_id).with("1234-joe-bloggs")
      get :index, :author_id => "1234-joe-bloggs"
      assigns[:author].should eq(author)
    end
    
    it "assigns title" do
      get 'index', :author_id => "1234-joe-bloggs"
      assigns[:title].should == "Joe Bloggs – Guardian articles"
    end
    
    it "assigns section" do
      get 'index', :author_id => "1234-joe-bloggs"
      assigns[:section].should == "Authors"
    end
    
    it "assigns theme" do
      get 'index', :author_id => "1234-joe-bloggs"
      assigns[:theme].should == "authors"
    end
    
    context "when there are results" do      
      it "assigns articles" do
        Article.should_receive(:search).with("Joe Bloggs")
        get 'index', :author_id => "1234-joe-bloggs"
        assigns[:articles].length.should == 2
      end 
    end
    
    context "when there are no results" do
      before(:each) do
        Article.stub(:search).and_return([])
      end
      
      it "assigns articles" do
        Article.should_receive(:search).with("Joe Bloggs")
        get 'index', :author_id => "1234-joe-bloggs"
        assigns[:articles].length.should == 0
      end
    end
    
    context "when Article raises a GuardianApiError exception" do
      before(:each) do
        Article.stub(:search).and_raise(Exceptions::GuardianApiError)
      end
      
      it "assigns error" do
        Article.should_receive(:search).with("Joe Bloggs")
        get 'index', :author_id => "1234-joe-bloggs"
        assigns[:error].should == "There was a problem connecting to The Guardian website."
      end
    end
    
    describe "setting layout" do
      it "uses the application layout for normal requests" do
        get :index, :author_id => "1234-joe-bloggs"
        response.should render_template("layouts/application")
      end

      it "uses no layout for PJAX requests" do
        request.env['X-PJAX'] = 'true'
        get :index, :author_id => "1234-joe-bloggs"
        response.should_not render_template("layouts/application")
      end
    end
  end
  
  describe "GET 'show'" do
    let(:article) { { "fields" => { "headline" => "Article title" }} }
    
    context "when article is returned successfully" do
      before(:each) do
        Article.stub(:find).and_return(article)
      end

      it "succeeds" do
        get :show, :author_id => "1234-joe-bloggs", :id => 'foo/bar'
        response.should be_success
      end
      
      it "sets the cache headers to an hour" do
        get :show, :author_id => "1234-joe-bloggs", :id => 'foo/bar'
        response.headers['Cache-Control'].should == 'public, max-age=3600'
      end

      it "assigns author" do
        Author.should_receive(:find_by_eibf_id).with("1234-joe-bloggs")
        get :show, :author_id => "1234-joe-bloggs", :id => 'foo/bar'
        assigns[:author].should eq(author)
      end

      it "assigns article" do
        Article.should_receive(:find).with('foo/bar')
        get :show, :author_id => "1234-joe-bloggs", :id => 'foo/bar'
        assigns[:article].should eq(article)
      end

      it "assigns fields" do
        get :show, :author_id => "1234-joe-bloggs", :id => 'foo/bar'
        assigns[:fields].should eq(article['fields'])
      end

      it "assigns title" do
        get 'show', :author_id => "1234-joe-bloggs", :id => 'foo/bar'
        assigns[:title].should == "Article title"
      end
    end
    
    context "when article is not returned" do
      before(:each) do
        Article.stub(:find).and_return(nil)
      end
      
      it "404s" do
        lambda {
          get :show, :author_id => "1234-joe-bloggs", :id => 'foo/bar'
        }.should raise_exception(ActionController::RoutingError)
      end
    end
    
    context "when Article raises a GuardianApiError exception" do
      before(:each) do
        Article.stub(:find).and_raise(Exceptions::GuardianApiError)
      end
      
      it "assigns error" do
        get :show, :author_id => "1234-joe-bloggs", :id => 'foo/bar'
        assigns[:error].should == "There was a problem connecting to The Guardian website."
      end
      
      it "assigns title" do
        get :show, :author_id => "1234-joe-bloggs", :id => 'foo/bar'
        assigns[:title].should == "Guardian article"
      end
    end
    
  end

end

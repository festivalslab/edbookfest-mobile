require 'spec_helper'

describe Article do
    
  describe "#search" do
    context "valid, populated response" do
      before(:each) do
        stub_guardian_request("search", "guardian_valid_search.json")
      end

      it "returns the articles" do
        articles = Article.search "Joe Bloggs"
        FakeWeb.should have_requested(:get, /content\.guardianapis\.com\/search/)
        articles.should have_exactly(25).items
      end

      it "uses the correct query string params" do
        articles = Article.search "Joe Bloggs"
        expected_fields = %w{headline trailText shortUrl standfirst thumbnail byline publication}.join('%2C')
        FakeWeb.should have_requested(:get, /q=Joe%20Bloggs/)
        FakeWeb.should have_requested(:get, /section=books%7Cchildrens-books-site/)
        FakeWeb.should have_requested(:get, /page-size=25/)
        FakeWeb.should have_requested(:get, /format=json/)
        FakeWeb.should have_requested(:get, /show-fields=#{expected_fields}/)
        FakeWeb.should have_requested(:get, /api-key=#{ENV["EIBF_GUARDIAN_API"]}/)
      end

      it "returns the correct article details" do
        articles = Article.search "Joe Bloggs"
        first = articles[0]
        first['webTitle'].should == "Why every novelist is holding out for a hero"
        first['apiUrl'].should == "http://content.guardianapis.com/books/2011/jul/17/literary-career-heroes-robert-mccrum"
        first['fields']['standfirst'].should == "Only by creating an enduring character can a writer entertain thoughts of a literary career"
        first['fields']['byline'].should == "Robert McCrum"
      end
    end
    
    context "valid, empty response" do
      before(:each) do
        stub_guardian_request("search", "guardian_empty_search.json")
      end
      
      it "returns 0 items" do
        articles = Article.search "Joe Bloggs"
        articles.should have_exactly(0).items
      end
    end
    
    context "404 response" do
      before(:each) do
        stub_guardian_error_request("search", "guardian_404_item.html", 404)
      end
      
      it "returns 0 items" do
        articles = Article.search "Joe Bloggs"
        articles.should have_exactly(0).items
      end
    end
    
    context "403 response (e.g. invalid API key)" do
      before(:each) do
        stub_guardian_error_request("search", "guardian_403_invalid.json", 403, "application/json")
      end
      
      it "raises a GuardianApi exception" do
        lambda {
          articles = Article.search "Joe Bloggs"
        }.should raise_exception Exceptions::GuardianApiError
      end
    end
  end
  
  describe "#find" do
    context "valid, populated response" do
      before(:each) do
        stub_guardian_request("foo", "guardian_valid_item.json")
      end
      
      it "uses the correct query string params" do
        article = Article.find "foo/bar"
        FakeWeb.should have_requested(:get, /content\.guardianapis\.com\/foo\/bar/)
        FakeWeb.should have_requested(:get, /format=json/)
        FakeWeb.should have_requested(:get, /show-fields=all/)
        FakeWeb.should have_requested(:get, /api-key=#{ENV["EIBF_GUARDIAN_API"]}/)
      end
      
      it "returns the correct article details" do
        article = Article.find "foo/bar"
        article['webTitle'].should == "Why every novelist is holding out for a hero"
        article['webUrl'].should == "http://www.guardian.co.uk/books/2011/jul/17/literary-career-heroes-robert-mccrum"
        article['fields']['headline'].should == "Why every novelist is holding out for a hero"
        article['fields']['body'].should =~ /Despite the received wisdom of the book trade, writers don't have careers in the conventional sense\./
        article['fields']['standfirst'].should == "Only by creating an enduring character can a writer entertain thoughts of a literary career"
        article['fields']['thumbnail'].should == "http://static.guim.co.uk/sys-images/Observer/Pix/pictures/2011/7/12/1310476468178/Sherlock-Holmes-McCrum-003.jpg"
        article['fields']['byline'].should == "Robert McCrum"
      end
    end
    
    context "404 not found response" do
      before(:each) do
        stub_guardian_error_request("foo", "guardian_404_item.html", 404)
      end
      
      it "returns nil" do
        article = Article.find "foo/bar"
        article.should be_nil
      end
    end
    
    context "403 response (e.g. invalid API key)" do
      before(:each) do
        stub_guardian_error_request("foo", "guardian_403_invalid.json", 403, "application/json")
      end
      
      it "raises a GuardianApi exception" do
        lambda {
          articles = Article.find "foo/bar"
        }.should raise_exception Exceptions::GuardianApiError
      end
    end
  end
end



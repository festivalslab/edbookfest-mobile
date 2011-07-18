require 'spec_helper'

describe Article do
    
  describe "#search" do
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
end



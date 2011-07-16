require 'spec_helper'

describe Article do
    
  describe "#search" do
    before(:each) do
      stub_guardian_request("search", "guardian_valid_search.json")
    end
    
    it "returns the articles" do
      articles = Article.search "Joe Bloggs"
      FakeWeb.should have_requested(:get, /search/)
      articles.should have_exactly(10).items
    end
  end
end

require 'spec_helper'

# rake task will:
# d = Feed.load_url('http://..')
# Feed.update(d)

# doc = Nokogiri::XML(open(Rails.root + 'spec/support/tesoriere.xml'))
# Nokogiri::XML::Document.stub!(:parse)
# Nokogiri::XML::Document.should_receive(:parse).and_return(doc)

describe Feed do
  let(:feed) { Feed.new }
  let(:doc) { Nokogiri::XML(open(Rails.root + 'spec/support/listings.xml')) }
  let(:url) { "http://foo.bar/woo" } 
  
  before(:each) do
    feed.stub!(:open)
    Nokogiri::XML::Document.stub!(:parse).and_return(:doc)
  end
  
  describe "#load_url" do
    before(:each) do
      feed.stub!(:open)
      Nokogiri::XML::Document.stub!(:parse).and_return(:doc)
    end
    
    it "calls load" do
      feed.should_receive(:open).with(url)
      feed.load_url url
    end
    
    it "creates a Nokogiri XML doc" do
      Nokogiri::XML::Document.should_receive(:parse)
      feed.load_url url
    end
  end
  
  describe "#update" do
    before(:each) do
      feed.load_url(url)
    end
    
    describe "events" do
      it "creates the correct number of events" do
        pending
        feed.update
        Event.all.count.should == 30
      end
    end
  end
end
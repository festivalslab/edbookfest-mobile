require 'spec_helper'

# rake task will:
# d = Feed.load_url('http://..')
# Feed.update(d)

describe Feed do
  let(:feed) { Feed.new }
  let(:listings) { open(Rails.root + 'spec/support/listings.xml') } 
  let(:doc) { Nokogiri::XML(listings) }
  let(:url) { "http://foo.bar/woo" } 
  
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
      feed.stub!(:open).and_return(listings)
      feed.load_url(url)
    end
    
    describe "events" do
      let(:expected_count) { 32 } 
      
      it "creates the correct number of events" do
        feed.update
        Event.all.count.should == expected_count
      end
      
      it "does not create duplicates" do
        pending "make it work"
        feed.update
        feed.update
        Event.all.count.should == expected_count
      end
    end
  end
end
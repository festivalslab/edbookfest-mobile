require 'spec_helper'

# rake task will:
# d = Feed.load_url('http://..')
# Feed.update(d)

# doc = Nokogiri::XML(open(Rails.root + 'spec/support/tesoriere.xml'))
# Nokogiri::XML::Document.stub!(:parse)
# Nokogiri::XML::Document.should_receive(:parse).and_return(doc)

describe Feed do
  describe "#load_url" do
    let(:url) { "http://foo.bar/woo" } 
    
    before(:each) do
      Feed.stub!(:open)
      Nokogiri::XML::Document.stub!(:parse)
    end
    
    it "calls load" do
      Feed.should_receive(:open).with(url)
      Feed.load_url url
    end
    
    it "creates a Nokogiri XML doc" do
      Nokogiri::XML::Document.should_receive(:parse)
      Feed.load_url url
    end
  end
end
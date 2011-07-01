require 'spec_helper'

describe Feed::Import do
  let(:import) { Feed::Import.new }
  let(:listings) { open(Rails.root + 'spec/support/listings.xml') } 
  let(:doc) { Nokogiri::XML(listings) }
  let(:url) { "http://foo.bar/woo" }
  let(:username) { "foo" } 
  let(:password) { "bar" }
  
  describe "#load_url" do
    before(:each) do
      import.stub!(:open)
      Nokogiri::XML::Document.stub!(:parse).and_return(:doc)
    end
    
    it "calls open" do
      import.should_receive(:open).with(url, :http_basic_authentication => [username, password])
      import.load_url url, username, password
    end
    
    it "creates a Nokogiri XML doc" do
      Nokogiri::XML::Document.should_receive(:parse)
      import.load_url url, username, password
    end
  end
  
  describe "#update" do
    before(:each) do
      import.stub!(:open).and_return(listings)
      import.load_url url, username, password
    end
    
    describe "events" do
      let(:expected_count) { 32 } 
      
      it "creates the correct number of events" do
        import.update
        Event.all.count.should == expected_count
      end
      
      it "does not create duplicates" do
        import.update
        import.update
        Event.all.count.should == expected_count
      end
      
      it "creates the correct data for one event" do
        import.update
        e = Event.first
        e.eibf_id.should == 2055
        e.title.should == "Keep Them Reading: Book Awards"
        e.sub_title.should == "Come and hear how to set up young adult book awards as a way to keep children reading."
        e.standfirst.should == "Librarians, Jacob Hope and Yvonne Manning describe how awards can be a fantastic way to create a buzz and sense of excitement around reading."
        e.start_time.should == DateTime.parse('2011-08-18T17:00:00+01:00')
        e.date.should == Date.parse('2011-08-18')
        e.is_sold_out.should_not be_true
        e.event_type.should == "Children"
      end
      
      it "updates the attributes of an existing event" do
        Event.create({
          :eibf_id => 2055,
          :title => 'The original title',
        })
        import.update
        Event.first.title.should == "Keep Them Reading: Book Awards"
      end
      
      it "deletes events that are not in the feed" do
        Event.create :eibf_id => 1234567
        import.update
        Event.find_by_eibf_id(1234567).should be_nil
      end
    end
  end
end
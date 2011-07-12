require 'spec_helper'

describe Feed::Import do
  let(:listings) { open(Rails.root + 'spec/support/listings.xml') } 
  let(:doc) { Nokogiri::XML(listings) }
  let(:url) { "http://foo.bar/woo" }
  let(:username) { "foo" } 
  let(:password) { "bar" }
  
  describe "#load_url" do
    before(:each) do
      Nokogiri::XML::Document.stub!(:parse).and_return(:doc)
    end
    
    it "calls open with http basic authentication" do
      import = Feed::Import.new(url, username, password)
      import.stub!(:open)
      import.should_receive(:open).with(url, :http_basic_authentication => [username, password])
      import.load false
    end
    
    it "calls open with no authentication" do
      import = Feed::Import.new(url)
      import.stub!(:open)
      import.should_receive(:open).with(url)
      import.load false
    end
    
    it "creates a Nokogiri XML doc" do
      import = Feed::Import.new(url)
      import.stub!(:open)
      Nokogiri::XML::Document.should_receive(:parse)
      import.load false
    end
  end
  
  describe "#update" do
    let(:import) { Feed::Import.new(url) }
    
    before(:each) do
      import.stub!(:open).and_return(listings)
      import.load false
    end
    
    describe "events" do
      let(:expected_count) { 32 } 
      
      it "creates the correct number of events" do
        import.update false
        Event.all.count.should == expected_count
      end
      
      it "does not create duplicates" do
        import.update false
        import.update false
        Event.all.count.should == expected_count
      end
      
      it "creates the correct data for one event" do
        import.update false
        e = Event.first
        e.eibf_id.should == 2055
        e.title.should == "Keep Them Reading: Book Awards"
        e.sub_title.should == "Come and hear how to set up young adult book awards as a way to keep children reading."
        e.standfirst.should == "Librarians, Jacob Hope and Yvonne Manning describe how awards can be a fantastic way to create a buzz and sense of excitement around reading."
        e.start_time.should == DateTime.parse('2011-08-18T17:00:00+01:00')
        e.date.should == Date.parse('2011-08-18')
        e.is_sold_out.should_not be_true
        e.event_type.should == "Children"
        e.title_sponsors.should == "Event title sponsors"
        e.duration.should == 60
        e.venue.should == "RBS Corner Theatre"
        e.description.should == "Come and hear how to set up young adult book awards as a way to keep children reading. Librarians, Jacob Hope and Yvonne Manning describe how awards can be a fantastic way to create a buzz and sense of excitement around reading, and how much both readers and authors can benefit from the experience."
        e.price.should == '&pound;7.00, <span class="concession">&pound;5.00</span>'
        e.image.should == "http://www.edbookfest.co.uk/uploads/event/event-image.jpg"
        e.theme.should == "Guest Selector: Julia Donaldson"
        e.main_site_url.should == "http://www.edbookfest.co.uk/the-festival/whats-on/keep-them-reading-book-awards"
      end
      
      it "updates the attributes of an existing event" do
        Event.create({
          :eibf_id => 2055,
          :title => 'The original title',
        })
        import.update false
        Event.first.title.should == "Keep Them Reading: Book Awards"
      end
      
      it "deletes events that are not in the feed" do
        Event.create :eibf_id => 1234567
        import.update false
        Event.find_by_eibf_id(1234567).should be_nil
      end
    end
    
    describe "authors" do
      let(:import_removed_author) { Feed::Import.new(url) }
      let(:listings_removed_author) { open(Rails.root + 'spec/support/listings_removed_author.xml') } 
      
      before(:each) do
        import_removed_author.stub!(:open).and_return(listings_removed_author)
        import_removed_author.load false
      end
      
      it "does not create an author association where there aren't any" do
        import.update false
        e = Event.first
        e.authors.should have_exactly(0).items
      end
      
      it "creates the correct number of authors" do
        import.update false
        e = Event.where(:eibf_id => 2056).first
        e.authors.should have_exactly(2).items
      end
      
      it "does not create duplicate author associations" do
        import.update false
        import.update false
        e = Event.where(:eibf_id => 2056).first
        e.authors.should have_exactly(2).items
      end
      
      it "creates the correct author information" do
        import.update false
        e = Event.where(:eibf_id => 2056).first
        a1, a2 = e.authors[0], e.authors[1]
        a1.eibf_id.should == 5592
        a1.first_name.should == "Sue"
        a1.last_name.should == "Palmer"
        a2.eibf_id.should == 6278
        a2.first_name.should == "Neal"
        a2.last_name.should == "Hoskins"
      end
      
      it "removes an author from the association when no longer appearing in feed" do
        import.update false
        import_removed_author.update false
        e = Event.where(:eibf_id => 2056).first
        e.authors.should have_exactly(1).items
        a1 = e.authors[0]
        a1.eibf_id.should == 5592
        a1.first_name.should == "Sue"
        a1.last_name.should == "Palmer"
      end
      
      it "adds new authors when added to feed" do
        import_removed_author.update false
        import.update false
        e = Event.where(:eibf_id => 2056).first
        e.authors.should have_exactly(2).items
      end
      
    end
  end
end
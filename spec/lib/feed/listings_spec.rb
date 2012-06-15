require 'spec_helper'

describe Feed::Listings do
  let(:listings_file) { open(Rails.root + 'spec/support/listings.xml') } 
  let(:doc) { Nokogiri::XML(listings) }
  let(:url) { "http://foo.bar/woo" }
  let(:username) { "foo" } 
  let(:password) { "bar" }
  
  describe "#load_url" do
    before(:each) do
      Nokogiri::XML::Document.stub!(:parse).and_return(:doc)
    end
    
    it "calls open with http basic authentication" do
      listings = Feed::Listings.new(url, username, password)
      listings.stub!(:open)
      listings.should_receive(:open).with(url, :http_basic_authentication => [username, password])
      listings.load false
    end
    
    it "calls open with no authentication" do
      listings = Feed::Listings.new(url)
      listings.stub!(:open)
      listings.should_receive(:open).with(url)
      listings.load false
    end
    
    it "creates a Nokogiri XML doc" do
      listings = Feed::Listings.new(url)
      listings.stub!(:open)
      Nokogiri::XML::Document.should_receive(:parse)
      listings.load false
    end
  end
  
  describe "#update" do
    let(:listings) { Feed::Listings.new(url) }
    
    before(:each) do
      listings.stub!(:open).and_return(listings_file)
      listings.load false
    end
    
    describe "events" do
      let(:expected_count) { 32 } 
      
      it "creates the correct number of events" do
        listings.update false
        Event.all.count.should == expected_count
      end
      
      it "does not create duplicates" do
        listings.update false
        listings.update false
        Event.all.count.should == expected_count
      end
      
      it "creates the correct data for one event" do
        listings.update false
        e = Event.first
        e.eibf_id.should == 2055
        e.title.should == "Keep Them Reading: Book Awards"
        e.sub_title.should == "Come and hear how to set up young adult book awards as a way to keep children reading."
        e.standfirst.should == "Librarians, Jacob Hope and Yvonne Manning describe how awards can be a fantastic way to create a buzz and sense of excitement around reading."
        e.start_time.should == DateTime.parse('2011-08-18T17:00:00+01:00')
        e.end_time.should == DateTime.parse('2011-08-18T18:00:00+01:00')
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
        listings.update false
        Event.first.title.should == "Keep Them Reading: Book Awards"
      end
      
      context "the feed contains events" do
        it "deletes events that are not in the feed" do
          Event.create :eibf_id => 1234567
          listings.update false
          Event.find_by_eibf_id(1234567).should be_nil
        end
      end
      
      context "the feed is empty" do
        let(:listings_empty) { Feed::Listings.new(url) }
        let(:listings_empty_file) { open(Rails.root + 'spec/support/listings_empty.xml') }
      
        before(:each) do
          listings_empty.stub!(:open).and_return(listings_empty_file)
          listings_empty.load false
        end
        
        it "deletes all the events" do
          Event.create
          Event.create
          listings_empty.update false
          Event.all.count.should == 0
        end
      end
    end
    
    describe "authors" do
      let(:listings_removed_author) { Feed::Listings.new(url) }
      let(:listings_removed_author_file) { open(Rails.root + 'spec/support/listings_removed_author.xml') } 
      
      before(:each) do
        listings_removed_author.stub!(:open).and_return(listings_removed_author_file)
        listings_removed_author.load false
      end
      
      it "does not create an author association where there aren't any" do
        listings.update false
        e = Event.first
        e.authors.should have_exactly(0).items
      end
      
      it "creates the correct number of authors" do
        listings.update false
        e = Event.find_by_eibf_id(2056)
        e.authors.should have_exactly(2).items
      end
      
      it "does not create duplicate author associations" do
        listings.update false
        listings.update false
        e = Event.find_by_eibf_id(2056)
        e.authors.should have_exactly(2).items
      end
      
      it "creates the correct author information" do
        listings.update false
        e = Event.find_by_eibf_id(2056)
        a1, a2 = e.authors[0], e.authors[1]
        a1.eibf_id.should == 5592
        a1.first_name.should == "Sue"
        a1.last_name.should == "Palmer"
        a1.image.should == ""
        a2.eibf_id.should == 6278
        a2.first_name.should == "Neal"
        a2.last_name.should == "Hoskins"
      end
      
      it "removes an author from the association when no longer appearing in feed" do
        listings.update false
        listings_removed_author.update false
        e = Event.find_by_eibf_id(2056)
        e.authors.should have_exactly(1).items
        a1 = e.authors[0]
        a1.eibf_id.should == 5592
        a1.first_name.should == "Sue"
        a1.last_name.should == "Palmer"
      end
      
      it "deletes the orphaned author" do
        listings.update false
        listings_removed_author.update false
        Author.find_by_eibf_id(6278).should be_nil
      end
      
      it "adds new authors when added to feed" do
        listings_removed_author.update false
        listings.update false
        e = Event.find_by_eibf_id(2056)
        e.authors.should have_exactly(2).items
      end
      
      it "adds an image when present" do
        listings.update false
        e = Event.find_by_eibf_id(2060)
        a1 = e.authors[0]
        a1.image.should == "http://www.edbookfest.co.uk/uploads/author/Donaldson_Julia.jpg"
      end
    end
    
    describe "books" do
      let(:listings_removed_book) { Feed::Listings.new(url) }
      let(:listings_removed_book_file) { open(Rails.root + 'spec/support/listings_removed_book.xml') } 
      
      before(:each) do
        listings_removed_book.stub!(:open).and_return(listings_removed_book_file)
        listings_removed_book.load false
      end
      
      it "does not create a book association where there aren't any" do
        listings.update false
        e = Event.first
        e.books.should have_exactly(0).items
      end
      
      it "creates the correct number of books" do
        listings.update false
        e = Event.find_by_eibf_id(2060)
        e.books.should have_exactly(2).items
      end
      
      it "does not create duplicate book associations" do
        listings.update false
        listings.update false
        e = Event.find_by_eibf_id(2060)
        e.books.should have_exactly(2).items
      end
      
      it "creates the correct book information" do
        listings.update false
        e = Event.find_by_eibf_id(2060)
        b1, b2 = e.books[0], e.books[1]
        b1.eibf_id.should == 7539
        b1.title.should == "Freddie and The Fairy"
        b1.amazon_url.should == "http://www.amazon.co.uk/Freddie-Fairy-Julia-Donaldson/dp/0330511181%3FSubscriptionId%3DAKIAIWK2ZMBUAZJRUKIA%26tag%3Dedinbinterboo-21%26linkCode%3Dxm2%26camp%3D2025%26creative%3D165953%26creativeASIN%3D0330511181"
        b1.isbn.should == "9780330511186"
        b1.amazon_image.should == "http://ecx.images-amazon.com/images/I/51uPRQNsC7L._SL110_.jpg"
        b2.eibf_id.should == 7565
        b2.title.should == "Zog"
        b2.amazon_url.should == "http://www.amazon.co.uk/Zog-Julia-Donaldson/dp/1407115561%3FSubscriptionId%3DAKIAIWK2ZMBUAZJRUKIA%26tag%3Dedinbinterboo-21%26linkCode%3Dxm2%26camp%3D2025%26creative%3D165953%26creativeASIN%3D1407115561"
        b2.isbn.should == "9781407115566"
        b2.amazon_image.should == "http://ecx.images-amazon.com/images/I/51soTM7-ctL._SL110_.jpg"
      end
      
      it "removes the book from the association when no longer appearing in feed" do
        listings.update false
        listings_removed_book.update false
        e = Event.find_by_eibf_id(2060)
        e.books.should have_exactly(1).items
        b1 = e.books[0]
        b1.eibf_id.should == 7565
        b1.title.should == "Zog"
        b1.amazon_url.should == "http://www.amazon.co.uk/Zog-Julia-Donaldson/dp/1407115561%3FSubscriptionId%3DAKIAIWK2ZMBUAZJRUKIA%26tag%3Dedinbinterboo-21%26linkCode%3Dxm2%26camp%3D2025%26creative%3D165953%26creativeASIN%3D1407115561"
        b1.isbn.should == "9781407115566"
        b1.amazon_image.should == "http://ecx.images-amazon.com/images/I/51soTM7-ctL._SL110_.jpg"
      end
      
      it "adds new books when added to feed" do
        listings_removed_book.update false
        listings.update false
        e = Event.find_by_eibf_id(2060)
        e.books.should have_exactly(2).items
      end
      
      it "does not import books without isbns" do
        listings.update false
        Book.find_by_eibf_id(7142).should be_nil
      end
    end
    
    describe "application settings" do
      it "clears the festival theme cache" do
        @cache = double("ActiveSupport::Cache::Store")
        Rails.stub(:cache).and_return(@cache)
        @cache.should_receive(:delete).with('current_theme')
        listings.update false
      end
    end
  end
end
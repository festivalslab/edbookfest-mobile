require 'spec_helper'

describe EventsController do
  
  let(:expected_theme) { "events" }
  let(:expected_section) { "Events" }
  let(:fest_start) { Date.new(2011,8,13) }
  let(:fest_end) { Date.new(2011,8,29) }
  
  before(:each) do
    Festival.stub(:start_date).and_return(fest_start)
    Festival.stub(:end_date).and_return(fest_end)
    Festival.stub(:date_in_festival).and_return(true)
  end
  
  describe "setting layout" do
    it "uses the application layout for normal requests" do
      get :calendar
      response.should render_template("layouts/application")
    end
    
    it "uses no layout for PJAX requests" do
      request.env['X-PJAX'] = 'true'
      get :calendar
      response.should_not render_template("layouts/application")
    end
  end

  describe "GET 'calendar'" do
    it "should be successful" do
      get :calendar
      response.should be_success
    end
    
    it "sets the cache headers to an hour" do
      get :calendar
      response.headers['Cache-Control'].should == 'public, max-age=3600'
    end
    
    it "assigns @theme" do
      get :calendar
      assigns[:theme].should eq(expected_theme)
    end
    
    it "assigns @section" do
      get :calendar
      assigns[:section].should eq(expected_section)
    end
    
    it "assigns @title" do
      get :calendar
      assigns[:title].should eq("Events calendar")
    end
    
    it "assigns @start_date" do
      get :calendar
      assigns[:start_date].should eq(fest_start)
    end
    
    it "assigns @end_date" do
      get :calendar
      assigns[:end_date].should eq(fest_end)
    end
    
  end
  
  describe "GET 'index'" do    
    context "when a date is provided" do
      context "and when the date is during the festival" do
        let(:date) { Date.new(2011,8,13) }
        
        before(:each) do
          Event.stub(:on_date).and_return([1,2])
        end

        it "should be successful" do
          get :index, :date => date.to_s
          response.should be_success
        end
        
        it "sets the cache headers to a minute" do
          get :index, :date => date.to_s
          response.headers['Cache-Control'].should == 'public, max-age=60'
        end
        
        it "assigns @theme" do
          get :index, :date => date.to_s
          assigns[:theme].should eq(expected_theme)
        end
        
        it "assigns @section" do
          get :index, :date => date.to_s
          assigns[:section].should eq(expected_section)
        end
        
        it "assigns @title" do
          get :index, :date => date.to_s
          assigns[:title].should eq("Events for Sat 13 Aug 2011")
        end

        it "assigns @date" do
          get :index, :date => date.to_s
          assigns[:date].should eq(date);
        end
        
        it "assigns @heading" do
          get :index, :date => date.to_s
          assigns[:heading].should eq("Sat 13 Aug 2011")
        end
        
        describe "when no type parameter is provided" do
          it "requests adult events for a date and assigns them to @events" do
            Event.should_receive(:on_date).with(date, "Adult")
            get :index, :date => date.to_s
            assigns[:events].should eq([1,2])
            assigns[:type].should eq("Adult")
          end
        end
        
        describe "when type parameter is provided with 'adult'" do
          it "requests adult events for a date and assigns them to @events" do
            Event.should_receive(:on_date).with(date, "Adult")
            get :index, :date => date.to_s, :type => "Adult"
            assigns[:events].should eq([1,2])
            assigns[:type].should eq("Adult")
          end
        end
        
        describe "when type parameter is provided with 'children'" do
          it "requests child events for a date and assigns them to @events" do
            Event.should_receive(:on_date).with(date, "Children")
            get :index, :date => date.to_s, :type => "Children"
            assigns[:events].should eq([1,2])
            assigns[:type].should eq("Children")
          end
        end
      end
      
      context "when the date is not during the festival" do
        let(:date) { Date.new(2011,8,12) } 
        
        before(:each) do
          Festival.stub(:date_in_festival).and_return(false)
        end
        
        it "raises a routing error" do
          lambda {
            get :index, :date => date.to_s
          }.should raise_exception(ActionController::RoutingError)
        end
      end
    end
    
    context "when a date is not provided" do
      context "and today is not during the festival" do
        let(:date) { Date.new(2011,8,12) } 
        
        before(:each) do
          Festival.stub(:date_in_festival).and_return(false)
          Delorean.time_travel_to date
        end
        
        after(:each) do
          Delorean.back_to_the_present
        end
        
        it "redirects to the calendar" do
          get :index
          response.should redirect_to calendar_url
        end
        
        it "sets the cache headers to a minute" do
          get :index
          response.headers['Cache-Control'].should == 'public, max-age=60'
        end
      end
      
      context "and today is during the festival" do
        let(:date) { Date.new(2011,8,13) } 
        
        before(:each) do
          Delorean.time_travel_to date
        end
        
        after(:each) do
          Delorean.back_to_the_present
        end
        
        context "and there are events on now" do
          before(:each) do
            Event.stub(:on_now).and_return([3,4])
          end
          
          it "sets the cache headers to a minute" do
            get :index
            response.headers['Cache-Control'].should == 'public, max-age=60'
          end
          
          it "assigns title" do
            get :index
            assigns[:title].should eq("")
          end
          
          it "requests events that are on now and assigns them to @on_now" do
            Event.should_receive(:on_now)
            get :index
            assigns[:on_now].should eq([3,4])
          end
          
          it "does not request other events" do
            Event.should_not_receive(:on_date)
            get :index
          end
          
          it "renders the on_now view" do
            get :index
            response.should render_template :on_now
          end
        end
        
        context "and there are no events on now" do
          before(:each) do
            Event.stub(:on_now).and_return([])
            Event.stub(:on_date).and_return([1,2])
          end
          
          it "sets the cache headers to a minute" do
            get :index
            response.headers['Cache-Control'].should == 'public, max-age=60'
          end
          
          it "requests adult events for a date and assigns them to @events" do
            Event.should_receive(:on_date).with(date, "Adult")
            get :index
            assigns[:events].should eq([1,2])
            assigns[:type].should eq("Adult")
          end
          
          it "assigns @heading" do
            get :index
            assigns[:heading].should eq("Today at the Festival")
          end
        end
      end
    end
  end
  
  describe "GET 'show'" do
    let(:event) { mock_model("Event").as_null_object } 
    
    before(:each) do
      Event.stub(:find_by_eibf_id).and_return event
    end
    
    it "should be successful" do
      get :show, :id => "1234-title"
      response.should be_success
    end
    
    it "sets the cache headers to an hour" do
      get :show, :id => "1234-title"
      response.headers['Cache-Control'].should == 'public, max-age=3600'
    end
    
    it "requests the event" do
      Event.should_receive(:find_by_eibf_id).with("1234-title")
      get :show, :id => "1234-title"
    end
    
    it "assigns @event" do
      get :show, :id => "1234-title"
      assigns[:event].should eq event
    end
    
    it "assigns @title" do
      event.stub(:title).and_return "My Title"
      get :show, :id => "1234-title"
      assigns[:title].should eq "My Title"
    end
    
    it "assigns @authors" do
      event.stub(:authors).and_return ["author"]
      get :show, :id => "1234-title"
      assigns[:authors].should eq ["author"]
    end
    
    describe "amazon lookups for books" do
      before(:each) do
        @book = mock_model("Book").as_null_object
        event.stub(:books).and_return [@book]
      end
      
      it "assigns @books" do
        get :show, :id => "1234-title"
        assigns[:books].should eq [@book]
      end

      it "assigns @amazon_books" do
        amazon_book = double("AmazonBook").as_null_object
        @book.stub(:amazon_lookup).and_return amazon_book
        get :show, :id => "1234-title"
        assigns[:amazon_books].should eq [amazon_book]
      end
    end
  end
end

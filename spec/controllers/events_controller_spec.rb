require 'spec_helper'

describe EventsController do
  
  let(:expected_theme) { "events" }
  let(:fest_start) { Date.new(2011,8,13) }
  let(:fest_end) { Date.new(2011,8,29) }
  
  before(:each) do
    Festival.stub!(:start_date).and_return(fest_start)
    Festival.stub!(:end_date).and_return(fest_end)
  end

  describe "GET 'calendar'" do
    it "should be successful" do
      get :calendar
      response.should be_success
    end
    
    it "assigns @theme" do
      get :calendar
      assigns[:theme].should eq(expected_theme)
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

end

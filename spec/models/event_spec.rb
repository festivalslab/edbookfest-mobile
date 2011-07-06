require 'spec_helper'

describe Event do
  describe "#on_date scope" do
    let(:date) { Date.new(2011,8,13) }
    
    before(:each) do
      @today1 = Factory.create(:event, :date => date, :start_time => DateTime.new(2011,8,13,13,0,0), :title => "Event 1") 
      @today2 = Factory.create(:event, :date => date, :start_time => DateTime.new(2011,8,13,14,0,0), :title => "Event 2")
      @today3 = Factory.create(:event, :date => date, :start_time => DateTime.new(2011,8,13,13,30,0), :title => "Event B")
      @today4 = Factory.create(:event, :date => date, :start_time => DateTime.new(2011,8,13,13,30,0), :title => "Event A")
      @tomorrow = Factory.create(:event, :date => date + 1)
      @todayChild1 = Factory.create(:event, :date => date, :start_time => DateTime.new(2011,8,13,13,0,0), :title => "Child Event 1", :event_type => "Children")
      @todayChild2 = Factory.create(:event, :date => date, :start_time => DateTime.new(2011,8,13,14,0,0), :title => "Child Event 2", :event_type => "Children")
      @tomorrowChild1 = Factory.create(:event, :date => date + 1, :event_type => "Children")
    end
    
    it "only returns adult events for that day" do
      events = Event.on_date(date, "Adult")
      events.count.should == 4
    end
    
    it "orders adult events by start time then by title" do
      events = Event.on_date(date, "Adult")
      events[0].should == @today1
      events[1].should == @today4
      events[2].should == @today3
      events[3].should == @today2
    end
    
    it "returns only child events for that day" do
      events = Event.on_date(date, "Children")
      events.count.should == 2
      events[0].should == @todayChild1
      events[1].should == @todayChild2
    end
  end
end

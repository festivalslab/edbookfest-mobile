require 'spec_helper'

describe Event do
  describe "#on_date scope" do
    let(:date) { Date.new(2011,8,13) }
    
    before(:each) do
      @today1 = Factory.create(:event, :date => date, :start_time => DateTime.new(2011,8,13,13,0,0)) 
      @today2 = Factory.create(:event, :date => date, :start_time => DateTime.new(2011,8,13,14,0,0))
      @today3 = Factory.create(:event, :date => date, :start_time => DateTime.new(2011,8,13,13,30,0))
      @tomorrow = Factory.create(:event, :date => date + 1)
    end
    
    it "only returns events for that day" do
      events = Event.on_date(date)
      events.count.should == 3
    end
    
    it "order events by start time" do
      events = Event.on_date(date)
      events[0].should == @today1
      events[1].should == @today3
      events[2].should == @today2
    end
  end
end

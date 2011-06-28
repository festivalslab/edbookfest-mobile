require 'spec_helper'

describe EventsHelper do
  
  let(:fest_start) { Date.new(2011,8,13) }
  let(:fest_end) { Date.new(2011,8,29) } 
  
  describe "#render_calendar_cell" do
    it "returns nil if date is before start of festival" do
      output = render_calendar_cell(Date.new(2011,8,12), fest_start, fest_end)
      output.should be_nil
    end
    
    it "returns nil if date is after end of festival" do
      output = render_calendar_cell(Date.new(2011,8,30), fest_start, fest_end)
      output.should be_nil
    end
    
    it "returns anchor if date is in festival date range" do
      output = render_calendar_cell(Date.new(2011,8,13), fest_start, fest_end)
      output[0].should == "<a href=\"#\">13</a>"
    end
    
    it "sets the cell class if date is in festival date range" do
      output = render_calendar_cell(Date.new(2011,8,13), fest_start, fest_end)
      output[1].should == {:class => "events"}
    end
  end
end

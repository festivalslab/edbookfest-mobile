require 'spec_helper'

describe Festival do
  describe "#start_date" do
    it "returns a date" do
      Festival.start_date.should be_a(Date)
    end
  end
  
  describe "#end_date" do
    it "returns a date" do
      Festival.end_date.should be_a(Date)
    end
    
    it "should be after the start date" do
      Festival.end_date > Festival.start_date
    end
  end
  
  describe "#date_in_festival" do
    it "returns true for a date during the festival" do
      date = Date.new(2011,8,13)
      Festival.date_in_festival(date).should be_true
    end
    
    it "returns false for a date outside the festival" do
      date = Date.new(2011,8,12)
      Festival.date_in_festival(date).should_not be_true
    end
  end
  
  describe "#is_launched" do
    context "when there are events" do
    end
      it "returns true" do
        Event.create
        Festival.is_launched.should be_true
      end
    
    context "when there are no events" do
      it "returns false" do
        Festival.is_launched.should_not be_true
      end
    end
  end
end
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
end
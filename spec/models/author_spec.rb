require 'spec_helper'

describe Author do
  before(:each) do
    @author = Author.new
  end
  
  describe "Event has_many_through association" do
    it "allows an author association" do
      @author.events.build
      @author.should have(:no).errors_on(:events)
    end
  end
  
  describe "#without_events" do
    it "does not select an author that still has events" do
      @author.events.build
      @author.save
      Author.without_events.should have_exactly(0).items
    end
    
    it "selects an author that has no events" do
      @author.save
      Author.without_events.should have_exactly(1).items
    end
  end
  
  describe "#full_name" do
    it "returns full name from first_name and last_name" do
      @author.first_name = "Joe"
      @author.last_name = "Bloggs"
      @author.full_name.should == "Joe Bloggs"
    end
  end
end

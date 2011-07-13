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
end

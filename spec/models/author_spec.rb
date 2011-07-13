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
  
  describe "#remove_authors_without_events" do
    it "does not delete an author that still has events" do
      @author.events.build
      @author.save
      Author.remove_authors_without_events
      @author.should_not be_nil
      @author.events.should have_exactly(1).items
    end
    
    it "deletes an author that has no events" do
      @author.save
      Author.remove_authors_without_events
      expect { Author.find(@author.id) }.to raise_error
    end
  end
end

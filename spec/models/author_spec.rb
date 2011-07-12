require 'spec_helper'

describe Author do
  describe "Event has_many_through association" do
    before(:each) do
      @author = Author.new
    end
    
    it "allows an author association" do
      @author.events.build
      @author.should have(:no).errors_on(:events)
    end
  end
end

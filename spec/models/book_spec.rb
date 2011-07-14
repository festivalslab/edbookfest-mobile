require 'spec_helper'

describe Book do
  before(:each) do
    @book = Book.new
  end
  
  describe "Event has_many_through association" do
    it "allows a book association" do
      @book.events.build
      @book.should have(:no).errors_on(:events)
    end
  end
  
  describe "#without_events" do
    it "does not select a book that still has events" do
      @book.events.build
      @book.save
      Book.without_events.should have_exactly(0).items
    end
    
    it "selects a book that has no events" do
      @book.save
      Book.without_events.should have_exactly(1).items
    end
  end
end
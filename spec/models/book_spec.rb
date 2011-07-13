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
end

require 'spec_helper'

describe BookHelper do
  describe "#availability" do
    it "outputs correctly for available stock" do
      availability("available").should == "<p class=\"availability available\">This book is <strong>available</strong></p>"
    end
    
    it "outputs correctly for limited availability stock" do
      availability("limited").should == "<p class=\"availability limited\">This book has <strong>limited availability</strong></p>"
    end
    
    it "outputs correctly for out of stock" do
      availability("none").should == "<p class=\"availability none\">This book is currently <strong>out of stock</strong></p>"
    end
    
    it "outputs correctly for nil" do
      availability(nil).should == "<p class=\"availability none\">This book is currently <strong>out of stock</strong></p>"
    end
  end
end

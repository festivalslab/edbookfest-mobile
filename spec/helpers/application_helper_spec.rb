require 'spec_helper'

describe ApplicationHelper do
  describe "#time_tag" do
    let(:date_time) { DateTime.new(2011,8,13,15,30) }
    
    it "renders the time element with the yielded text" do
      output = time_tag(date_time) { "my text" }
      output.should == '<time datetime="2011-08-13T15:30:00+00:00">my text</time>'
    end
    
    it "renders the time element with an optional class name" do
      output = time_tag(date_time, "my-class") { "my text" }
      output.should == '<time class="my-class" datetime="2011-08-13T15:30:00+00:00">my text</time>'
    end
  end
  
  describe "#format_string_date" do
    let(:date_time_text) { "2011-07-17T00:05:14+01:00" }
    
    before(:each) do
      Date::DATE_FORMATS[:test] = '%e %b %Y'
    end
    
    it "outputs a formatted date" do
      output = format_string_date(date_time_text, :test)
      output.should == "17 Jul 2011"
    end
  end
end

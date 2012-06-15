require 'spec_helper'

describe FestivalTheme do

context "With themes" do
  let(:previous_date_time) { DateTime.new(2011,6,20,12,00) }
  let(:current_date_time) { DateTime.new(2012,6,21,12,00) }
  let(:next_date_time) { DateTime.new(2013,6,21,12,00) }
  
  let(:date_time) { DateTime.new(2012,6,21,12,30) }
  
  before(:each) do
    Delorean.time_travel_to date_time
    @previous = Factory.create(:festival_theme, :show_from  => previous_date_time)
    @current = Factory.create(:festival_theme, :show_from  => current_date_time)
    @next = Factory.create(:festival_theme, :show_from  => next_date_time)
  end
   
  after(:each) do
      Delorean.back_to_the_present
  end
  
  describe "#current" do

    before(:each) do
      
    end

    it "returns the current theme" do
      FestivalTheme.current.should == @current
    end
    
    it "caches the current theme for one minute" do
      @cache = double("ActiveSupport::Cache::Store")
      Rails.stub(:cache).and_return(@cache)
      @cache.should_receive(:read).with('current_theme').and_return(nil)
      @cache.should_receive(:write).with('current_theme', @current, {:ttl => 60.seconds})
      FestivalTheme.current
    end
    
    it "returns the theme from cache if found" do
      @cache = double("ActiveSupport::Cache::Store")
      Rails.stub(:cache).and_return(@cache)
      @cache.should_receive(:read).with('current_theme').and_return(@previous)
      @cache.should_not_receive(:write)
      FestivalTheme.current.should == @previous
    end
    
  end
  
  describe "#active?" do

    context "when the theme is current" do
      it "returns true" do
        @current.active?.should == true
      end
    end
    
    context "when the theme is not yet active" do
      it "returns false" do
        @next.active?.should == false
      end
    end
    
    context "when a later theme is active" do
      it "returns false" do
        @previous.active?.should == false
      end
    end
  end
  
  describe "#high" do
    it "returns a Paperclip object" do
      @current.high.should be_an_instance_of(Paperclip::Attachment)
    end
  end
  
  describe "#medium" do
    it "returns a Paperclip object" do
      @current.medium.should be_an_instance_of(Paperclip::Attachment)
    end
  end
  
  describe "#low" do
    it "returns a Paperclip object" do
      @current.low.should be_an_instance_of(Paperclip::Attachment)
    end
  end
  
  describe "#shortcut" do
    it "returns a Paperclip object" do
      @current.shortcut.should be_an_instance_of(Paperclip::Attachment)
    end
  end
  
  describe "#high" do
    it "returns a Paperclip object" do
      @current.splash.should be_an_instance_of(Paperclip::Attachment)
    end
  end
end

context "Without themes" do
  describe "#current" do

    it "returns a blank theme" do
      FestivalTheme.current.should be_an_instance_of(FestivalTheme)
    end
    
    it "does not cache" do
      @cache = double("ActiveSupport::Cache::Store")
      Rails.stub(:cache).and_return(@cache)
      @cache.should_receive(:read).with('current_theme').and_return(nil)
      @cache.should_not_receive(:write)
      
      FestivalTheme.current
    end
    
  end
  
  describe "#high" do
    it "has the default high-res url" do
      FestivalTheme.current.high.url.should ==  "h/apple-touch-icon.png"
    end
  end
  
  describe "#medium" do
    it "has the default medium-res url" do
      FestivalTheme.current.medium.url.should ==  "m/apple-touch-icon.png"
    end
  end
  
  describe "#low" do
    it "has the default low-res url" do
      FestivalTheme.current.low.url.should ==  "l/apple-touch-icon-precomposed.png"
    end
  end
  
  describe "#shortcut" do
    it "has the default url" do
      FestivalTheme.current.shortcut.url.should ==  "l/apple-touch-icon.png"
    end
  end
  
  describe "#splash" do
    it "has the default splash url" do
      FestivalTheme.current.splash.url.should ==  "l/splash.png"
    end
  end

end

end

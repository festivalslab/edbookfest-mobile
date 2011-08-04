require 'spec_helper'

describe JacketImage do
  
  let(:url) { "http://amazon.com/some/image.jpg" }
  let(:height) { "160" }
  let(:width) { "102" }
  let(:image_hash) { { 
    "URL" => url, 
    "Height" => { "Units" => "pixels", "__content__" => height },
    "Width" => { "Units" => "pixels", "__content__" => width } 
  } }
  
  before(:each) do
    @jacket_image = JacketImage.new image_hash
  end
  
  it "returns the source url" do
    @jacket_image.src.should == "http://amazon.com/some/image.jpg"
  end
  
  it "returns native width" do
    @jacket_image.width.should == 102
  end
  
  it "returns native height" do
    @jacket_image.height.should == 160
  end
  
  it "returns ratio between width and height" do
    @jacket_image.ratio.should == 0.6375
  end
  
  it "returns a rounded height based on width and ratio" do
    @jacket_image.ratio_height(40).should == 63
  end
  
end

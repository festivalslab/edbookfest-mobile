require 'spec_helper'

describe ArticlesHelper do
  describe "#guardian_body" do
    let(:thumbnail) { 'path/to/image.jpg' } 
    
    context "when there is body content" do
      let(:content) { '<p>Some text.</p>' }
      
      it "returns the content" do
        guardian_body(content, nil).should == content
      end
      
      it "returns the content and the image" do
        guardian_body(content, thumbnail).should == "<img src=\"path/to/image.jpg\" alt=\"\">#{content}"
      end
    end
    
    context "where there is no content except for a comment" do
      let(:content) { '<!-- This content is not available -->' }
      it "returns a message explaining that content is not available" do
        guardian_body(content, nil).should == '<p class="not-available">This article is only available on The Guardian website.</p>'
      end
      
      it "retursn only the message, even when there is an image" do
        guardian_body(content, thumbnail).should == '<p class="not-available">This article is only available on The Guardian website.</p>'
      end
    end
    
    context "when the content is nil" do
      let(:content) { nil }
      
      it "returns a message explaining that content is not available" do
        guardian_body(content, nil).should == '<p class="not-available">This article is only available on The Guardian website.</p>'
      end
      
      it "retursn only the message, even when there is an image" do
        guardian_body(content, thumbnail).should == '<p class="not-available">This article is only available on The Guardian website.</p>'
      end
    end
  end
end

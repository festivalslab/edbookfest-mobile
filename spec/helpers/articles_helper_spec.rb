require 'spec_helper'

describe ArticlesHelper do
  describe "#guardian_body" do
    context "when there is body content" do
      let(:content) { '<p>Some text.</p>' }
      it "returns the content" do
        guardian_body(content).should == content
      end
    end
    
    context "where there is no content except for a comment" do
      let(:content) { '<!-- This content is not available -->' }
      it "returns a message explaining that content is not available" do
        guardian_body(content).should == '<p class="not-available">This article is only available on The Guardian website.</p>'
      end
    end
  end
end

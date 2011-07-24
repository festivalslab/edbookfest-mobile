# encoding: UTF-8
require 'spec_helper'

def get_response(isbn)
  request = Sucker.new
  request << {
    'Operation' => 'ItemLookup',
    'IdType' => 'EAN',
    'ItemId' => isbn.to_s,
    'ResponseGroup' => 'Images,ItemAttributes,EditorialReview',
    'SearchIndex' => 'Books'
  }
  request.get
end

describe AmazonBook do
  
  context "valid response with description and review" do
    use_vcr_cassette "amazon_book"
    
    let(:isbn) { "9781409103479" } # The Complaints by Ian Rankin
    let(:response) { get_response(isbn) } 
    
    before(:each) do
      @amazon_book = AmazonBook.new(response)
    end
    
    it "returns the author" do
      @amazon_book.author.should == "Ian Rankin"
    end
    
    it "returns the product description" do
      @amazon_book.product_description.should == "The brand new No.1 bestseller from Britain's best-loved crime writer..."
    end
    
    it "returns the jacket image" do
      @amazon_book.jacket_image.should == "http://ecx.images-amazon.com/images/I/51sg218Ru8L._SL160_.jpg"
    end
    
    it "returns the amazon review" do
      @amazon_book.amazon_review.should == "It must be a double-edged sword to be Ian Rankin. Of course it's comforting to be Britain's best-selling male crime writer -- and to have created one of the most iconic characters in detective fiction in the irascible (and indomitable) D. I. Jack Rebus. But Rankin -- a writer who has clearly never been content to simply repeat himself -- had made it clear that there would be a finite number of Rebus books (the character, after all, was ageing in real time as Rankin had always planned that he should do). And with <i>Exit Music</i> he wrote <i>finis</i> to the career of his tough Glaswegian cop. But Rankin had made a rod for his own back: a less high-profile writer might get away with a change of pace which didn't quite come off -- not so Ian Rankin. And fortunately, the standalone heist novel which was the first post-Rebus book, <i>Doors Open</i>, was a winner and proved categorically that there was life after Rebus.<p>With <i>The Complaints</i>, we have the first novel by Ian Rankin featuring a new protagonist, another Edinburgh copper, Malcolm Fox. But Fox is quite a different character to his predecessor, although both men are imposing physically. For a start, Fox doesn't drink and is initially less confrontational than the bolshie Rebus. But where the latter’s taste in music ran (like the author’s) to rock music -- Rankin fans know about the Rebus titles echoing those of the Rolling Stones -- Fox is more inclined to listen to serious music. The city, however, is the same, and although some may regret that the massively talented Rankin has not moved into new territory along with his new copper, there's no denying that the author is the ultimate modern chronicler of Edinburgh, with a gift for pungent evocation worthy of his great Scottish literary predecessors. And it's a relief to report that <i>The Complaints</i> augurs very well for any further books featuring Malcolm Fox. <p>Fox is part of the unpopular Complaints & Conduct department of the police force (better known as ‘The Complaints’) -- and the reason for that unpopularity is clear to see: this is the department designed to root out corruption in the force and investigate suspect officers. The current target for Fox is policeman Glenn Heaton of the CID, who has often sailed close to the edge; now there appears to be material for a case against him. But at the same time, another cop, Jamie Breck, is suspected of being part of a ring indulging in child abuse. Fox is in for some jawdropping surprises regarding his colleague, and the shifting relationship between the two men is at the core of this finely honed narrative (along with Fox's treatment of his ailing father -- something else which differentiates this book from its predecessors).<p> There will, of course, be Rebus fans who would have been happy for Rankin to go on creating new problem for his awkward copper, but most admirers of the author will be happy with this striking change of pace -- and will be hungry for further outings for Malcolm Fox and the Complaints unit. --<I>Barry Forshaw</I>"
    end
    
    it "returns the publisher" do
      @amazon_book.publisher.should == "Orion"
    end
    
    it "returns the publication date" do
      @amazon_book.publication_date.should == Date.new(2010,8,5)
    end
    
    it "returns the page count" do
      @amazon_book.page_count.should == "496"
    end
  end
  
  context "valid response without review or description" do
    use_vcr_cassette "amazon_book"
    
    let(:isbn) { "9780099548973" } # The Leopard by Jo Nesbo
    let(:response) { get_response(isbn) }
    
    before(:each) do
      @amazon_book = AmazonBook.new(response)
    end
    
    it "returns nil when asking for the description" do
      @amazon_book.product_description.should be_nil
    end
    
    it "returns nil when asking for the amazon review" do
      @amazon_book.amazon_review.should be_nil
    end
  end
  
  context "valid response without jacket image" do
    use_vcr_cassette "amazon_book"
    
    let(:isbn) { "9781846471292" } # The Stolen Sister by Joan Lingard 
    let(:response) { get_response(isbn) }
    
    before(:each) do
      @amazon_book = AmazonBook.new(response)
    end
    
    it "returns nil when asking for the jacket image" do
      @amazon_book.jacket_image.should be_nil
    end
  end
end

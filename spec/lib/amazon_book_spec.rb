# encoding: UTF-8
require 'spec_helper'

def get_lookup_response(isbn)
  request = Sucker.new
  request << {
    'Operation' => 'ItemLookup',
    'IdType' => 'EAN',
    'ItemId' => isbn.to_s,
    'ResponseGroup' => 'Images,ItemAttributes,EditorialReview,AlternateVersions',
    'SearchIndex' => 'Books'
  }
  request.get
end

def get_kindle_response(asin)
  request = Sucker.new
  request << {
    'Operation' => 'ItemLookup',
    'IdType' => 'ASIN',
    'ItemId' => asin,
    'ResponseGroup' => 'ItemAttributes'
  }
  request.get
end

describe AmazonBook do
  describe "standard item lookup" do
    context "valid response with description and review" do
      use_vcr_cassette "amazon_book"

      let(:isbn) { "9781409103479" } # The Complaints by Ian Rankin
      let(:response) { get_lookup_response isbn } 

      before(:each) do
        @amazon_book = AmazonBook.new response
      end

      it "returns the author" do
        @amazon_book.authors.should == ["Ian Rankin"]
      end

      it "returns the product description" do
        @amazon_book.product_description.should == "The brand new No.1 bestseller from Britain's best-loved crime writer..."
      end

      it "returns the jacket image" do
        @amazon_book.jacket_image.should == "http://ecx.images-amazon.com/images/I/51sg218Ru8L._SL160_.jpg"
      end

      it "returns the amazon review" do
        @amazon_book.amazon_review.should =~ /It must be a double-edged sword to be Ian Rankin\. Of course it's comforting to be Britain's best-selling male crime writer/
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

      it "returns the amazon affiliate link" do
        @amazon_book.amazon_affiliate_link.should =~ /http:\/\/www\.amazon\.co\.uk\/Complaints-Ian-Rankin\/dp\/1409103471/
      end

      it "returns the kindle edition ASIN" do
        @amazon_book.kindle_asin.should == "B002S0KB4U"
      end
    end

    context "valid response without review or description" do
      use_vcr_cassette "amazon_book"

      let(:isbn) { "9780099548973" } # The Leopard by Jo Nesbo
      let(:response) { get_lookup_response isbn }

      before(:each) do
        @amazon_book = AmazonBook.new response
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
      let(:response) { get_lookup_response isbn }

      before(:each) do
        @amazon_book = AmazonBook.new response
      end

      it "returns nil when asking for the jacket image" do
        @amazon_book.jacket_image.should be_nil
      end
    end

    context "valid response with multiple authors" do
      use_vcr_cassette "amazon_book"

      let(:isbn) { "9780852652268" } # Pathways by David Stewart and Nicholas Rudd-Jones
      let(:response) { get_lookup_response isbn }

      before(:each) do
        @amazon_book = AmazonBook.new response
      end

      it "returns an array of authors" do
        @amazon_book.authors.should == ["David Stewart", "Nicholas Rudd-Jones"]
      end
    end

    context "valid response without kindle edition" do
      use_vcr_cassette "amazon_book"

      let(:isbn) { "9781848775565" } # Silly Doggy! by Adam Stower
      let(:response) { get_lookup_response isbn } 

      before(:each) do
        @amazon_book = AmazonBook.new response
      end

      it "returns nil for the kindle_asin" do
        @amazon_book.kindle_asin.should be_nil
      end
    end
  end
  
  describe "kindle lookup response" do
    context "valid response" do
      use_vcr_cassette "amazon_book_kindle"

      let(:asin) { "B002S0KB4U" } # The Complaints by Ian Rankin
      let(:response) { get_kindle_response asin } 

      before(:each) do
        @kindle_book = AmazonBook.new response
      end
      
      it "returns the kindle affiliate link" do
        @kindle_book.amazon_affiliate_link.should =~ /http:\/\/www\.amazon\.co\.uk\/The-Complaints-ebook\/dp\/B002S0KB4U/
      end
      
    end
  end
end

class AmazonBook
  def initialize(item)
    @item = item
  end
  
  def attrs
    @item['ItemAttributes']
  end
  
  def isbn
    attrs['EAN']
  end
  
  def title
    attrs['Title']
  end
  
  def authors
    auths = attrs['Author']
    (auths.is_a?(String)) ? [auths] : auths
  end
  
  def product_description
    review_content "Product Description"
  end
  
  def jacket_image
    return @jacket_image if @jacket_image
    image_item = @item['MediumImage']
    @jacket_image = (image_item) ? JacketImage.new(image_item) : ""
    @jacket_image
  end
  
  def amazon_review
    review_content "Amazon.co.uk Review"
  end
  
  def publisher
    attrs['Publisher']
  end
  
  def edition_binding
    attrs['Binding']
  end
  
  def publication_date
    date = attrs['PublicationDate']
    return nil unless date
    begin 
      Date.parse(date)
    rescue
      nil
    end
  end
  
  def page_count
    attrs['NumberOfPages']
  end
  
  def amazon_affiliate_link
    @item['DetailPageURL']
  end
  
  def kindle_asin
    return "" if @item['AlternateVersions'].nil? or @item['AlternateVersions']['AlternateVersion'].nil?
    kindle_alternate = @item['AlternateVersions']['AlternateVersion'].select { |av| av['Binding'] == 'Kindle Edition' }
    (kindle_alternate.empty?) ? "" : kindle_alternate.first['ASIN']
  end
  
  def in_stock?
    book = Book.find_by_isbn isbn
    book ? book.in_stock? : false
  end
  
private
  
  def review_content(type)
    return "" if @item['EditorialReviews'].nil? or @item['EditorialReviews']['EditorialReview'].nil?
    review_item = @item['EditorialReviews']['EditorialReview'].select { |r| r['Source'] == type }
    (review_item.empty?) ? "" : review_item.first['Content']
  end
  
end
class AmazonBook
  def initialize(item)
    @item = item
  end
  
  def attrs
    @item['ItemAttributes']
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
    image_item = @item['MediumImage']
    (image_item) ? image_item['URL'] : ""
  end
  
  def amazon_review
    review_content "Amazon.co.uk Review"
  end
  
  def publisher
    attrs['Publisher']
  end
  
  def publication_date
    date = attrs['PublicationDate']
    return nil if (date.empty?)
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
  
private
  
  def review_content(type)
    return "" if @item['EditorialReviews'].nil? or @item['EditorialReviews']['EditorialReview'].nil?
    review_item = @item['EditorialReviews']['EditorialReview'].select { |r| r['Source'] == type }
    (review_item.empty?) ? "" : review_item.first['Content']
  end
  
end
class AmazonBook
  def initialize(response)
    @response = response
  end
  
  def authors
    @response['Author']
  end
  
  def product_description
    review_content "Product Description"
  end
  
  def jacket_image
    image_item = @response['MediumImage']
    (image_item.empty?) ? nil : image_item.first['URL']
  end
  
  def amazon_review
    review_content "Amazon.co.uk Review"
  end
  
  def publisher
    @response['Publisher'].first
  end
  
  def publication_date
    date = @response['PublicationDate']
    (date.empty?) ? nil : Date.parse(date.first)
  end
  
  def page_count
    @response['NumberOfPages'].first
  end
  
  def amazon_affiliate_link
    @response['DetailPageURL'].first
  end
  
private
  
  def review_content(type)
    review_item = @response['EditorialReview'].select { |r| r['Source'] == type }
    (review_item.empty?) ? nil : review_item.first['Content']
  end
  
end
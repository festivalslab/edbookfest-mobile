class AmazonBook
  def initialize(response)
    @response = response
  end
  
  def author
    @response['Author'].first
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
    Date.parse @response['PublicationDate'].first
  end
  
  def page_count
    @response['NumberOfPages'].first
  end
  
private
  
  def review_content(type)
    review_item = @response['EditorialReview'].select { |r| r['Source'] == type }
    (review_item.empty?) ? nil : review_item.first['Content']
  end
  
end
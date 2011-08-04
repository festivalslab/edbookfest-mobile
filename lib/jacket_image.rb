class JacketImage
  
  def initialize(amazon_image)
    @amazon_image = amazon_image
  end
  
  def src
    @amazon_image['URL']
  end
  
  def width
    @amazon_image['Width']['__content__'].to_i
  end
  
  def height
    @amazon_image['Height']['__content__'].to_i
  end
  
  def ratio
    width.to_f / height.to_f
  end
  
  def ratio_height(w)
    (w / ratio).round
  end
  
end
module ApplicationHelper
  def time_tag(date_time, classes = nil, &block)
    content_tag(:time, :datetime => date_time.iso8601, :class => classes, &block)
  end
  
  def format_string_date(date_string, format)
    date_string.to_date.to_s format
  end
  
  def jacket_image(image, width = 40, alt = "")
    ratio = 1.5
    image_src = (image.present? && image.src) ? image.src : image_path('jacket-default.png')
    height = (image.present?) ? image.ratio_height(width) : (width * ratio).round
    image_tag image_src, { :alt => alt, :width => width, :height => height }
  end
end

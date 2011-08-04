module ApplicationHelper
  def time_tag(date_time, classes = nil, &block)
    content_tag(:time, :datetime => date_time.iso8601, :class => classes, &block)
  end
  
  def format_string_date(date_string, format)
    date_string.to_date.to_s format
  end
  
  def jacket_image(image, options)
    ratio = 1.5
    width = options[:width] || 40
    attributes = {
      :width => width,
      :height => (image.present?) ? image.ratio_height(width) : (width * ratio).round,
      :alt => options[:alt] || '',
      :class => options[:class]
    }
    image_src = (image.present? && image.src) ? image.src : image_path('jacket-default.png')
    image_tag image_src, attributes
  end
end

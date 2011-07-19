module ApplicationHelper
  def time_tag(date_time, classes = nil, &block)
    content_tag(:time, :datetime => date_time.iso8601, :class => classes, &block)
  end
  
  def format_string_date(date_string, format)
    date_string.to_date.to_s format
  end
end

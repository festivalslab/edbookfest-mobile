module EventsHelper
  def render_calendar_cell(date, start_date, end_date)
    ["<a href=\"#{listings_path(date)}\">#{date.day}</a>", {:class => "events"}] if date >= start_date && date <= end_date
  end
  
  def time_tag(date_time, &block)
    content_tag(:time, :datetime => date_time.iso8601, &block)
  end
end

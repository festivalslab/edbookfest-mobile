Factory.define :event do |f|
  f.sequence(:eibf_id) {|n| n }
  f.title "Event title"
  f.sub_title "Event subtitle"
  f.title_sponsors "Event title sponsors"
  f.theme "Event theme"
  f.standfirst "Event standfirst"
  f.description "<p>Event <strong>description</strong></p>"
  f.start_time DateTime.new(2011,8,13,15,0,0) # 4pm
  f.end_time DateTime.new(2011,8,13,16,0,0)
  f.date Date.new(2011,8,13)
  f.duration 60
  f.venue "Event venue"
  f.price "&pound;10 <span class=\"concession\">(&pound;8)</span>"
  f.image "/event/image.jpg"
  f.is_sold_out false
  f.event_type "Adult"
  f.main_site_url "http://edbookfest.co.uk/event/buy"
end
Factory.define :event do |f|
  f.sequence(:eibf_id) {|n| n }
  f.title "Event title"
  f.sub_title "Event subtitle"
  f.standfirst "Event standfirst content"
  f.start_time DateTime.new(2011,8,13,15,0,0)
  f.date Date.new(2011,8,13)
  f.is_sold_out false
  f.event_type "Adult"
end
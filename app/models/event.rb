class Event < ActiveRecord::Base  
  def self.on_date(date, event_type)
    where("events.date = ? AND events.event_type = ?", date, event_type).order("events.start_time ASC, events.title ASC")
  end
end
class Event < ActiveRecord::Base  
  def self.on_date(date)
    where("events.date = ?", date).order("events.start_time ASC, events.title ASC")
  end
end
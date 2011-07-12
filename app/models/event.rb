class Event < ActiveRecord::Base
  has_many :appearances
  has_many :authors, :through => :appearances
  
  def self.on_date(date, event_type)
    where("events.date = ? AND events.event_type = ?", date, event_type).order("events.start_time ASC, events.title ASC")
  end
end
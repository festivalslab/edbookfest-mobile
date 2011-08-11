class Event < ActiveRecord::Base
  has_many :appearances
  has_many :featured_books
  has_many :authors, :through => :appearances, :uniq => true
  has_many :books, :through => :featured_books, :uniq => true
  
  def self.on_date(date, event_type)
    where("events.date = ? AND events.event_type = ?", date, event_type).order("events.start_time ASC, events.title ASC")
  end
  
  def self.on_now
    now = DateTime.now
    where("events.date = ? AND events.start_time <= ? AND events.end_time >= ?", Date.today, now + 15.minutes, now - 15.minutes).order("events.start_time ASC")
  end
  
  def to_param
    "#{eibf_id}-#{title.parameterize}"
  end
  
  def add_author(author)
    authors << author
  end
  
  def add_book(book)
    books << book
  end
  
  def in_future?
    start_time > DateTime.now
  end
end
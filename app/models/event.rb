class Event < ActiveRecord::Base
  has_many :appearances
  has_many :featured_books
  has_many :authors, :through => :appearances, :uniq => true
  has_many :books, :through => :featured_books, :uniq => true
  
  def self.on_date(date, event_type)
    where("events.date = ? AND events.event_type = ?", date, event_type).order("events.start_time ASC, events.title ASC")
  end
  
  def add_author(author)
    authors << author
  end
  
  def add_book(book)
    books << book
  end
end
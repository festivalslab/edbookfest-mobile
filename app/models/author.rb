class Author < ActiveRecord::Base
  has_many :appearances
  has_many :events, :through => :appearances, :uniq => true
  
  def self.without_events
    includes(:appearances).where( :appearances => { :event_id => nil } )
  end
end

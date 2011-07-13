class Author < ActiveRecord::Base
  has_many :appearances
  has_many :events, :through => :appearances, :uniq => true
  
  def self.remove_authors_without_events
    includes(:appearances).where( :appearances => { :event_id => nil } ).destroy_all
  end
end

class Author < ActiveRecord::Base
  has_many :appearances
  has_many :events, :through => :appearances, :uniq => true
  
  def self.without_events
    includes(:appearances).where( :appearances => { :event_id => nil } )
  end
  
  def to_param
    "#{eibf_id}-#{full_name.parameterize}"
  end
  
  def full_name
    "#{first_name} #{last_name}"
  end
end

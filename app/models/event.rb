class Event < ActiveRecord::Base
  scope :on_date, lambda { |date| 
    {
      :conditions => { :date => date },
      :order => 'start_time ASC'
    }
  }
end

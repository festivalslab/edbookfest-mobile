class Festival
 
  def self.start_date
    Setting.defaults[:festival_start_date] = '2011-08-13'
    Date.parse(Setting.festival_start_date)
  end
  
  def self.end_date
    Setting.defaults[:festival_end_date] = '2011-08-29'
    Date.parse(Setting.festival_end_date)
  end
  
  def self.date_in_festival(date)
    date >= self.start_date && date <= self.end_date
  end
  
  def self.is_launched
    (Event.all.count > 0)
  end
end
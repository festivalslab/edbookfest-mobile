class Festival
  @@start_date = Date.new(2011,8,13)
  @@end_date = Date.new(2011,8,29)
  
  def self.start_date
    @@start_date
  end
  
  def self.end_date
    @@end_date
  end
  
  def self.date_in_festival(date)
    date >= @@start_date && date <= @@end_date
  end
end
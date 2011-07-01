require 'faker'

module Feed
  
  # Creates fake data using the faker gem
  # 
  # Usage:
  # 
  # To create 10 events per day
  #
  #   fake = Feed::Fake.new
  #   fake.update(10)
  class Fake
    @@year = 2011
    @@month = 8
    @@day_range = (13..29)
    @@event_types = ["Children", "Adults"]
    @@start_hour = 12
    
    def update(events_per_day = 30)
      Event.delete_all
      @@day_range.each { |day| update_one_day(day, events_per_day) }
    end
    
  private
  
    def update_one_day(day, events_per_day)
      date = Date.new(@@year, @@month, day)
      date_time = DateTime.new(@@year, @@month, day, @@start_hour)
      events_per_day.times do |i|
        e = Event.new(
          :eibf_id => day * 100 + i,
          :date => date,
          :start_time => date_time + (20 * i).minutes,
          :title => Faker::Lorem.words(5).join(" ").capitalize,
          :sub_title => Faker::Lorem.words(8).join(" ").capitalize,
          :standfirst => Faker::Lorem.words(12).join(" ").capitalize,
          :event_type => @@event_types.rand.to_s,
          :is_sold_out => [true,false].rand
        )

        e.save!
      end
    end
  
  end
end
  
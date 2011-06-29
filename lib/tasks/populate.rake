namespace :db do
  desc "Erase and populate database with faked data"
  task :sample => :environment do
    require 'faker'
    year = 2011
    month = 8
    event_types = ["Children", "Adults"]
    
    Event.delete_all
    (13..29).each do |day|
      date = Date.new(year, month ,day)
      date_time = DateTime.new(year, month, day, 12)
      30.times do |i|
        e = Event.new(
          :eibf_id => day * 100 + i,
          :date => date,
          :start_time => date_time + (20 * i).minutes,
          :title => Faker::Lorem.words(5).join(" ").capitalize,
          :sub_title => Faker::Lorem.words(8).join(" ").capitalize,
          :standfirst => Faker::Lorem.words(12).join(" ").capitalize,
          :event_type => event_types.rand.to_s,
          :is_sold_out => [true,false].rand
        )
        
        e.save!
      end
    end
    puts "#{Event.all.count} events created"
  end
end
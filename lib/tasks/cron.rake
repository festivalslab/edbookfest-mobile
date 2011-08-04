namespace :cron do
  desc "Run the cron tasks"
  task :run => :environment do
    Rake::Task["listings:import"].invoke
    Rake::Task["stock:import"].invoke
  end
end

desc "Cron task called by Heroku"
task :cron => :environment do
  frequency = Rails.application.config.cron_type
  run_cron = false
  case frequency
  when "daily"
    run_cron = true
  when "hourly"
    run_cron = true if Time.now.hour % 4 == 0
  end
  if run_cron then
    puts "Running cron at #{Time.now.to_s}. Cron frequency is #{frequency}."
    Rake::Task["cron:run"].invoke
  else
    puts "Cron not run at #{Time.now.to_s}. Cron frequency is #{frequency}."
  end
end
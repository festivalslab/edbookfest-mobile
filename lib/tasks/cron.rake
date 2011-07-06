desc "Cron task called by Heroku - used to run the feed:import task"
task :cron do
  Rake::Task["feed:import"].invoke
end
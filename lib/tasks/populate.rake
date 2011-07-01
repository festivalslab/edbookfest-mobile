namespace :feed do
  
  desc "Erase and populate database with faked data"
  task :fake => :environment do
    fake = Feed::Fake.new
    fake.update(30)
    puts "#{Event.all.count} events created"
  end
  
  desc "Imports feed from URL and updates / creates records accordingly"
  task :import => :environment do
    raise "Feed URL missing" if ENV['EIBF_FEED_URL'].nil?
    raise "Feed username missing" if ENV['EIBF_FEED_USERNAME'].nil?
    raise "Feed password missing" if ENV['EIBF_FEED_PASSWORD'].nil?
    url, username, password = ENV['EIBF_FEED_URL'], ENV['EIBF_FEED_USERNAME'], ENV['EIBF_FEED_PASSWORD']
    import = Feed::Import.new
    import.load_url(url, username, password)
    import.update
  end
  
end
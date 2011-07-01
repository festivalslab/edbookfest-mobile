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
    import = Feed::Import.new(url, username, password)
    import.load
    import.update
  end
  
  desc "Loads feed from URL and saves to tmp/feed/listings.xml"
  task :save => :environment do
    raise "Feed URL missing" if ENV['EIBF_FEED_URL'].nil?
    raise "Feed username missing" if ENV['EIBF_FEED_USERNAME'].nil?
    raise "Feed password missing" if ENV['EIBF_FEED_PASSWORD'].nil?
    url, username, password = ENV['EIBF_FEED_URL'], ENV['EIBF_FEED_USERNAME'], ENV['EIBF_FEED_PASSWORD']
    import = Feed::Import.new(url, username, password)
    file = import.load_file
    FileUtils.mkpath 'tmp/feed'
    open('tmp/feed/listings.xml', 'w') do |new_file|
      new_file << file.read
    end
  end
  
end
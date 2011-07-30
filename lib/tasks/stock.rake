namespace :stock do
  
  desc "Loads books stock feed from URL and saves to tmp/feed/stock.xml"
  task :save => :environment do
    raise "Stock feed URL missing" if ENV['EIBF_STOCK_URL'].nil?
    url = ENV['EIBF_STOCK_URL']
    stock = Feed::Stock.new url
    file = stock.load_file
    FileUtils.mkpath 'tmp/feed'
    open('tmp/feed/stock.xml', 'w') do |new_file|
      new_file << file.read
    end
  end
  
end
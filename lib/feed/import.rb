require 'nokogiri'
require 'open-uri'

module Feed
  
  # Imports data from the Edinburgh International Book Festival xml data feed.
  # 
  # Usage:
  # 
  #   import = Import.new
  #   import.load_url("http://myurl")
  #   import.update
  class Import
    
    def initialize(url, username = nil, password = nil)
      @url, @username, @password = url, username, password
      @events_modified = 0
    end
    
    # Loads feed data from a URL
    def load(output = true)
      @doc = Nokogiri::XML load_file(output) do |config|
        config.sax1
      end
      puts "Feed source has #{@doc.css('Event').size} events" if output
    end
    
    # Loads feed file
    def load_file(output = true)
      if (@username && @password) then
        file = open(@url, :http_basic_authentication => [@username, @password])
      else
        file = open(@url)
      end
      puts "Feed source loaded successfully" if output
      file
    end
    
    # Updates database records from feed data
    def update(output = true)
      eibf_ids = @doc.css('Event').map { |e| e['eibf_id'].to_i }
      Event.where("eibf_id not in (?)", eibf_ids).delete_all
      @doc.css('Event').each { |event| update_event(event) }
      puts "#{@events_modified} events added or modified" if output
      puts "There are now #{Event.all.count} events in the database" if output
    end
  
  private
    def update_event(event)
      eibf_id = event['eibf_id'].to_i
      e = Event.find_or_initialize_by_eibf_id(eibf_id)
      e.update_attributes({
        :title => event.at_css('Title MainTitle').text,
        :sub_title => event.at_css('Title SubTitle').text,
        :standfirst => event.at_css('Description Standfirst').text,
        :start_time => DateTime.parse(event.at_css('EventDateTime').text),
        :date => Date.parse(event.at_css('EventDateTime').text),
        :event_type => event['event_type'],
        :is_sold_out => event['isSoldOut']
      })
      @events_modified += 1
    end
  end
  
end
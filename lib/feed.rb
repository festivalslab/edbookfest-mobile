require 'nokogiri'
require 'open-uri'

class Feed
  
  def load_url(url)
    @doc = Nokogiri::XML(open(url))
  end
  
  def update()
    eibf_ids = @doc.css('Event').map { |e| e['eibf_id'].to_i }
    Event.where("eibf_id not in (?)", eibf_ids).delete_all
    @doc.css('Event').each { |event| update_event(event) }
  end
  
  def update_event(event)
    eibf_id = event['eibf_id'].to_i
    e = Event.find_or_initialize_by_eibf_id(eibf_id)
    e.update_attributes({
      :title => event.at_css('Title MainTitle').text,
      :sub_title => event.at_css('Title SubTitle').text,
      :standfirst => event.at_css('Description Standfirst').text,
      :start_time => DateTime.parse(event.at_css('EventDateTime').text),
      :date => Date.parse(event.at_css('EventDateTime').text),
      :event_type => event['event_type']
    })
  end
  
end
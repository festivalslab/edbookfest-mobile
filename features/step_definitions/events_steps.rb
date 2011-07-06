Given /^there (?:is|are) (\d+) (child|adult)?\s?(sold out)?\s?events? for (\d+)\/(\d+)\/(\d+) starting at (\d+):(\d+)$/ do |count, type, sold_out, day, month, year, hours, minutes|
  eventType = (type == "child") ? "Children" : "Adult"
  datePattern = "#{year}-#{month}-#{day}T#{hours}:#{minutes}:00+01:00"
  date = Date.parse datePattern
  dateTime = DateTime.parse datePattern
  count.to_i.times do |c|
    factory_options = {
      :date => date, 
      :start_time => dateTime + c.minutes, 
      :event_type => eventType
    }
    factory_options[:is_sold_out] = true if (sold_out)
    Factory.create(:event, factory_options)
  end
end

Given /^there are (\d+) events for (\d+)\/(\d+)\/(\d+) with the same start time$/ do |count, day, month, year|
  datePattern = "#{year}-#{month}-#{day}T#12:00:00+01:00"
  date = Date.parse datePattern
  dateTime = DateTime.parse datePattern
  chars = ('a'..'z').to_a.reverse
  count.to_i.times do |c|
    Factory.create(:event, :date => date, :start_time => dateTime, :title => "Event #{chars[c]}")
  end
end

When /^I click on day (\d+)$/ do |day|
  click_link(day)
end

When /^I click on event (\d+)$/ do |index|
  find(".events li:nth-child(#{index}) a").click
end

Then /^I should be on the listings page for (\d+)\/(\d+)\/(\d+)$/ do |day, month, year|
  current_path = URI.parse(current_url).path
  current_path.should == path_to("the listings page for #{day}/#{month}/#{year}")
end

Then /^I should be on the event detail page for event (\d+)$/ do |index|
  current_path = URI.parse(current_url).path
  current_path.should == path_to("the event detail page for #{index}")
end

Then /^I should see (\d+) (adult|child)?\s?events$/ do |count, event_type|
  list_class = event_type == "child" ? "children" : "adult"
  events = all(".events.#{list_class} li")
  events.length.should == count.to_i
end

Then /^event (\d+) starts before event (\d+)$/ do |index1, index2|
  event_before_time = DateTime.parse(find(selector_for("event #{index1}")).find('time')['datetime'])
  event_after_time = DateTime.parse(find(selector_for("event #{index2}")).find('time')['datetime'])
  event_after_time.should > event_before_time
end

Then /^event (\d+) has a start time of "(.+)"$/ do |index, time|
  event = find(selector_for("event #{index}"))
  event.should have_css("time", :text => time)
end

Then /^event (\d+) is (not)?\s?sold out$/ do |index, inv|
  event = find(selector_for("event #{index}"))
  if (inv) then
    event.should_not have_content('Sold out')
  else
    event.should have_content('Sold out')
  end
end

Then /^(child|adult)?\s?event (\d+) has a datetime of "([^"]*)"$/ do |event_type, index, datetime|
  type = (event_type == "child") ? "children" : "adult"
  event = find(selector_for("#{type} event #{index}"))
  event.should have_css("time[datetime='#{datetime}']")
end

Then /^event (\d+) has a title of "([^"]*)"$/ do |index, title|
  event = find(selector_for("event #{index}"))
  event.should have_css("h5", :text => title)
end

Then /^event (\d+) has a subtitle of "([^"]*)"$/ do |index, subtitle|
  event = find(selector_for("event #{index}"))
  event.should have_css(".subtitle", :text => subtitle)
end


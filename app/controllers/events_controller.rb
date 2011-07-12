class EventsController < ApplicationController
  helper CalendarHelper
  before_filter :set_theme, :set_section
  layout :set_layout
  
  def index
    @date = Date.parse(params[:date])
    not_found if @date.nil? || !Festival.date_in_festival(@date)
    @title = "Events for #{@date.to_s :title}"
    @adult_events = Event.on_date(@date, "Adult")
    @child_events = Event.on_date(@date, "Children")
  end
  
  def calendar
    @title = "Events calendar"
    @start_date = Festival.start_date
    @end_date = Festival.end_date
  end
  
  def show
    @event = Event.find(params[:id])
    @title = @event["title"]
  end
  
protected

  def set_theme
    @theme = "events"
  end
  
  def set_section
    @section = "Events"
  end
    
end

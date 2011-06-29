class EventsController < ApplicationController
  helper CalendarHelper
  before_filter :set_theme
  
  def index
    @date = Date.parse(params[:date])
    not_found if @date.nil? || !Festival.date_in_festival(@date)
    @events = Event.on_date(@date)
  end
  
  def calendar
    @start_date = Festival.start_date
    @end_date = Festival.end_date
  end
  
  def show
    
  end
  
protected

  def set_theme
    @theme = "events"
  end
end

class EventsController < ApplicationController
  helper CalendarHelper
  before_filter :set_theme, :set_section
  layout :set_layout
  
  def index
    set_cache(:home)
    if params[:date]
      @date = Date.parse(params[:date])
      not_found if @date.nil? || !Festival.date_in_festival(@date)
      @title = "Events for #{@date.to_s :title}"
      @heading = @date.to_s :title
      @type = params[:type].present? ? params[:type] : "Adult"
      @events = Event.on_date(@date, @type)
    else
      @date = Date.today
      redirect_to calendar_url unless Festival.date_in_festival(@date)
      @title = ""
      @on_now = Event.on_now
      if @on_now.any? then
        render :on_now
      else
        @type = params[:type].present? ? params[:type] : "Adult"
        @events = Event.on_date(@date, @type)
        @heading = "Today at the Festival"
      end
    end
  end
  
  def calendar
    @title = "Events calendar"
    @start_date = Festival.start_date
    @end_date = Festival.end_date
  end
  
  def show
    @event = Event.find_by_eibf_id(params[:id])
    @title = @event["title"]
    @authors = @event.authors
    @books = @event.books
    @amazon_books = @books.collect(&:amazon_lookup).compact
  end
  
protected

  def set_theme
    @theme = "events"
  end
  
  def set_section
    @section = "Events"
  end
    
end

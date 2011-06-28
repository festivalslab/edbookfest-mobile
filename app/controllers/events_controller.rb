class EventsController < ApplicationController
  helper CalendarHelper
  def calendar
    @theme = "events"
    @start_date = Festival.start_date
    @end_date = Festival.end_date
  end
end

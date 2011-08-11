class TimeController < ApplicationController
  def set
    not_found unless Rails.application.config.allow_time_manipulation
    date_time = DateTime.strptime("2011-08-#{params[:day]}T#{params[:hour]}:#{params[:minute]}+0100", "%Y-%m-%dT%H:%M%z")
    Delorean.time_travel_to date_time
    render :text => "Time set. Time is now #{DateTime.now}"
  end
  
  def reset
    not_found unless Rails.application.config.allow_time_manipulation
    Delorean.back_to_the_present
    render :text => "Time reset. Time is now #{DateTime.now}"
  end
end
class SettingsController < ApplicationController
  http_basic_authenticate_with :name => ENV["HTTP_USERNAME"], :password => ENV["HTTP_PASSWORD"], :realm => "Edbookfest-mobile administration"
  before_filter :set_theme, :set_section
  skip_before_filter :check_launched
  layout :set_layout
  
  def dates
    @title = "Settings - Festival Dates"
    @heading = "Festival Dates"
    @use_bootstrap = true
    @errors = Hash.new
    set_cache(:admin)
    
    if request.post? 
      # Set the parameters from the submitted data
      @festival_start_date = params[:festival_start_date]
      @festival_end_date = params[:festival_end_date]
      
      # Validate the values
      begin
        start_date = Date.strptime(@festival_start_date, '%d/%m/%Y')
      rescue ArgumentError
        @errors[:festival_start_date] = "Please enter a start date in day/month/year format"
      end
      begin
        end_date = Date.strptime(@festival_end_date, '%d/%m/%Y')
      rescue
        @errors[:festival_end_date] = "Please enter an end date in day/month/year format"
      end
      if (@errors.empty? && (end_date < start_date))
        @errors[:festival_end_date] = "The end date must be after the start date"
      end
      
      if (! @errors.empty?)
        return
      end
      
      # Set the values
      Setting.festival_start_date = start_date.to_s
      Setting.festival_end_date = end_date.to_s
      
      # Redirect back to the settings page to verify changes saved
      redirect_to settings_dates_url
    else
      @festival_start_date = Festival.start_date.strftime('%d/%m/%Y')
      @festival_end_date = Festival.end_date.strftime('%d/%m/%Y')
    end
  end
  
protected

  def set_theme
    @theme = "events"
  end
  
  def set_section
    @section = "Settings"
  end
  
end

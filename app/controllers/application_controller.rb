class ApplicationController < ActionController::Base
  protect_from_forgery
  http_basic_authenticate_with :name => ENV["HTTP_USERNAME"], :password => ENV["HTTP_PASSWORD"], :realm => "EIFB mobile site" if ENV["HTTP_AUTH_ACTIVE"]
  before_filter :page_cache, :check_launched
  
protected

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
  
  def set_layout
    @festival_theme = FestivalTheme.current
    request.headers['X-PJAX'] ? 'pjax' : 'application'
  end
  
  def page_cache
    set_cache
  end
  
  def set_cache(type = :default)
    cache_time = Rails.application.config.cache_times[type] * 60
    cache_header = cache_time > 0 ? "public, max-age=#{cache_time}" : "no-cache"
    response.headers['Cache-Control'] = cache_header
  end
  
  def check_launched
    if ! Festival.is_launched
      set_cache(:home)
      redirect_to coming_url
    end
  end

end

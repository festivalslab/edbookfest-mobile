class ApplicationController < ActionController::Base
  protect_from_forgery
  http_basic_authenticate_with :name => ENV["HTTP_USERNAME"], :password => ENV["HTTP_PASSWORD"], :realm => "EIFB mobile site" if ENV["HTTP_AUTH_ACTIVE"]
end

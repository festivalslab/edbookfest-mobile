# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
EdbookfestMobile::Application.initialize!

Haml::Template.options[:format] = :html5
Haml::Template.options[:attr_wrapper] = '"'

Date::DATE_FORMATS[:title] = '%a %e %b %Y'
Date::DATE_FORMATS[:time] = '%H:%M'
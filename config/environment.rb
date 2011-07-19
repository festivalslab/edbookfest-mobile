# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
EdbookfestMobile::Application.initialize!

Haml::Template.options[:format] = :html5
Haml::Template.options[:attr_wrapper] = '"'

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8
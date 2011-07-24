# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
EdbookfestMobile::Application.initialize!

Haml::Template.options[:format] = :html5
Haml::Template.options[:attr_wrapper] = '"'

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

Sucker.configure do |c|
  c.locale        = 'uk'
  c.key           = ENV['EIBF_AMAZON_KEY']
  c.secret        = ENV['EIBF_AMAZON_SECRET']
  c.associate_tag = ENV['EIBF_AMAZON_TRACKING_ID']
end
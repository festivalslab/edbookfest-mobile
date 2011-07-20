source 'http://rubygems.org'

# gem 'rails', '3.1.0.rc4'

gem 'rails', :git => 'git://github.com/rails/rails.git', :branch => '3-1-stable'
gem 'sprockets', :git => 'git://github.com/sstephenson/sprockets.git'

gem 'calendar_helper'
gem 'faker'
gem 'nokogiri'
gem 'httparty'
gem 'multi_json'

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'cucumber-rails'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'ZenTest'
  gem 'autotest-rails'
  gem 'delorean'
  gem 'factory_girl_rails'
  gem 'launchy'
  gem 'autotest-growl'
  gem 'guard'
  gem 'guard-coffeescript'
  gem 'guard-livereload'
  gem 'jasmine'
  gem 'fakeweb', :require => false
  gem 'fakeweb-matcher', :require => false
end

group :production do
  gem 'pg'
# gem 'therubyracer-heroku', '0.8.1.pre3'
end

# Asset template engines
gem 'haml-rails'
gem 'sass-rails', "~> 3.1.0.rc"
gem 'coffee-script'
gem 'uglifier'

gem 'jquery-rails'

# Webserver
gem 'thin'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end

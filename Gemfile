source 'http://rubygems.org'

gem 'rails', '3.1.0.rc2'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'calendar_helper', '~> 0.2.4'
gem 'faker'

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
end

group :production do
  gem 'pg'
  gem 'therubyracer-heroku', '0.8.1.pre3'
end

# Asset template engines
gem 'haml-rails'
gem 'sass-rails', "~> 3.1.0.rc"
gem 'coffee-script'
gem 'uglifier'

gem 'jquery-rails'

# Webserver
gem 'thin'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end

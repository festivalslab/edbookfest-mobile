# Deploy the application to Heroku on a successful build
# First, identify the deploy application based on branch

# Don't deploy pull requests
if ENV['TRAVIS_PULL_REQUEST'] == "true"
  puts "Pull request builds are not deployed"
  exit
end

# Map the branch to a heroku application
apps = {
  'master' =>     'edbookfest-test',
  'stage' =>      'edbookfest-stage',
  'production' => 'edbookfest' }

deploy_app = apps[ENV['TRAVIS_BRANCH']]

if deploy_app.nil?
  puts "Branch #{ENV['TRAVIS_BRANCH']} is not mapped to a heroku application in travis_deployer.rb - not deploying"
  exit
end

puts "Deploying build #{ENV['TRAVIS_JOB_NUMBER']} - branch #{ENV['TRAVIS_BRANCH']} at #{ENV['TRAVIS_COMMIT']} to #{deploy_app}"

# Install the Heroku gem
if !system 'gem install heroku'
  puts "Could not install heroku gem"
  exit $?
end

# Add the remote git branch
if !system "git remote add heroku git@heroku.com:#{deploy_app}"
  puts "Could not add git remote"
  exit $?
end

# Ignore SSH key verification for Heroku
known_hosts = File.expand_path("~/.ssh/config")
File.open(known_hosts, "a") do |f|
  f.puts <<-EOF
Host heroku.com
   StrictHostKeyChecking no
   CheckHostIP no
   UserKnownHostsFile=/dev/null
EOF
end

# Clear any existing heroku keys for our instance
if !system "heroku keys:clear"
  puts "Could not clear heroku keys"
  exit $?
end

# Add new heroku key
if !system "yes | heroku keys:add"
  puts "Could not add heroku keys"
  exit $?
end

# Deploy
if !system "git push heroku master"
  puts "Could not push new version"
  exit $?
end

# Run db:migrate
if !system "heroku run rake db:migrate"
  result = $?
  puts "Could not migrate database - attempting rollback"

  system "heroku rollback"
  exit result
end

# Restart the app
if !system "heroku restart"
  puts "Could not restart application"
  exit $?
end
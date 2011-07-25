VCR.config do |c|
  c.cassette_library_dir = 'features/support/cassettes'
  c.stub_with :webmock
  c.default_cassette_options = { :record => :new_episodes }
  c.ignore_localhost = true
end

VCR.cucumber_tags do |t|
  t.tags '@guardianapi', '@amazon_lookup'
end

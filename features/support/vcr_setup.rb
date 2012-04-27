VCR.config do |c|
  c.cassette_library_dir = 'features/support/cassettes'
  c.stub_with :webmock
  c.default_cassette_options = { :record => :once }
  c.ignore_localhost = true
  %w{EIBF_GUARDIAN_API EIBF_AMAZON_KEY EIBF_AMAZON_TRACKING_ID EIBF_AMAZON_SECRET}.each do |k| 
    c.filter_sensitive_data("<#{k}>") { ENV[k] }
  end
end

VCR.cucumber_tags do |t|
  t.tags '@guardianapi', '@amazon_lookup', '@amazon_search', '@kindle_lookup', '@itunes_lookup'
end

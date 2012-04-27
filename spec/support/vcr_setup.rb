VCR.config do |c|
  c.cassette_library_dir = 'spec/support/cassettes'
  c.stub_with :webmock
  c.default_cassette_options = { :record => :once }
  
  %w{EIBF_GUARDIAN_API EIBF_AMAZON_KEY EIBF_AMAZON_TRACKING_ID EIBF_AMAZON_SECRET}.each do |k| 
    c.filter_sensitive_data("<#{k}>") { ENV[k] }
  end
end
VCR.config do |c|
  c.cassette_library_dir = 'spec/support/cassettes'
  c.stub_with :webmock
  c.default_cassette_options = { :record => :new_episodes, :re_record_interval => 7.days }
end
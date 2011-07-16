FakeWeb.allow_net_connect = false

def guardian_url(url)
  /content\.guardianapis\.com\/#{url}/
end

def stub_guardian_request(url, filename, status=nil)
  options = {:body => ""}
  options.merge!({:body => fixture_file(filename)}) if filename
  options.merge!({:status => status}) if status
  options.merge!(:content_type => "application/json")
  FakeWeb.register_uri(:get, guardian_url(url), options)
end

def fixture_file(filename)
  return '' if filename == ''
  file_path = File.expand_path(File.dirname(__FILE__) + '/../fixtures/' + filename)
  File.read(file_path)
end
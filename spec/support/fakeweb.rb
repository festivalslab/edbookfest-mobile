FakeWeb.allow_net_connect = true

def guardian_url(url)
  /content\.guardianapis\.com\/#{url}/
end

def stub_guardian(url, filename=nil, status=nil, content_type="application/json")
  options = {:body => ""}
  options.merge!({:body => fixture_file(filename)}) if filename
  options.merge!({:status => status}) if status
  options.merge!(:content_type => content_type)
  FakeWeb.register_uri(:get, guardian_url(url), options)
end

def stub_guardian_request(url, filename=nil, status=nil)
  stub_guardian url, filename, status, "application/json"
end

def stub_guardian_error_request(url, filename=nil, status=404, content_type="text/html")
  stub_guardian url, filename, status, content_type
end

def fixture_file(filename)
  return '' if filename == ''
  file_path = File.expand_path(File.dirname(__FILE__) + '/../fixtures/' + filename)
  File.read(file_path)
end
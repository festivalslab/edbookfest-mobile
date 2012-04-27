require 'webmock'

Before('@nowebmock') do
  WebMock.disable!
end

After('@nowebmock') do
  WebMock.enable!
end
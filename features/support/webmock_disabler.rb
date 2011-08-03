require 'webmock'
require 'webmock/disabler'

Before('@nowebmock') do
  WebMock.disable!
end

After('@nowebmock') do
  WebMock.enable!
end
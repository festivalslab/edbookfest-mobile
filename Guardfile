# More info at https://github.com/guard/guard#readme

guard 'coffeescript', :output => 'public/javascripts/compiled' do
  watch /^app\/assets\/javascripts\/(.*)\.coffee/
end

guard 'coffeescript', :output => 'spec/javascripts' do
  watch /^spec\/coffeescripts\/(.*)\.coffee/
end

guard 'livereload', :apply_js_live => false do
  watch /^spec\/javascripts\/.+\.js$'/
  watch /^public\/javascripts\/compiled\/.+\.js$/
end

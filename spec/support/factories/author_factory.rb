Factory.define :author do |f|
  f.sequence(:eibf_id) {|n| n }
  f.first_name "Joe"
  f.last_name "Bloggs"
end
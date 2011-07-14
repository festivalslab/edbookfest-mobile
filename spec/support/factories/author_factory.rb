Factory.define :author do |f|
  f.sequence(:eibf_id) {|n| n }
  f.first_name "First"
  f.sequence(:last_name) {|n| "Last#{n}" }
  f.image nil
end
Factory.define :appearance do |appearance|
  appearance.association :event
  appearance.association :author
end
require 'delorean'

# restore time after each scenario
After do
  Delorean.back_to_the_present
end
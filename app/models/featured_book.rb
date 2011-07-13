class FeaturedBook < ActiveRecord::Base
  belongs_to :book
  belongs_to :event
end

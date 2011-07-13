class Appearance < ActiveRecord::Base
  belongs_to :event
  belongs_to :author
end

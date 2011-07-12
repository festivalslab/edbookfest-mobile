class Author < ActiveRecord::Base
  has_many :appearances
  has_many :events, :through => :appearances, :uniq => true
end

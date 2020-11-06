class WeekendPrice < ActiveRecord::Base
  attr_accessible :price

  validates(:price,presence:true)
end

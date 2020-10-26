class PriceModifier < ActiveRecord::Base
  attr_accessible :name, :price

  has_many :reservation_dates, dependent: :nullify
end

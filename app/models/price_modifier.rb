class PriceModifier < ActiveRecord::Base
  attr_accessible :name, :price, :from_date, :to_date

  has_many :reservation_dates, dependent: :nullify

  validates(:name,presence:true)
  validates(:price,presence:true)
end

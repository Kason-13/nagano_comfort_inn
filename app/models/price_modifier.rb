class PriceModifier < ActiveRecord::Base
  attr_accessible :name, :price

  has_many :reservation_dates, dependent: :nullify

  validates(:name,presence:true)
  validates(:price,presence:true, numericality: { greater_than: 0 })
end

require 'date'
class ReservationDate < ActiveRecord::Base
  attr_accessible :date, :different_price

  has_many :room_reservations
  belongs_to :price_modifier

  validates(:date, presence:true)

end

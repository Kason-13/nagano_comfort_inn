class Reservation < ActiveRecord::Base
  attr_accessible :client_id

  has_many :room_reservations, foreign_key: "reservation_id"

  validates(:client_id, presence:true)
end

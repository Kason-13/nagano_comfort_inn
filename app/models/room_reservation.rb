class RoomReservation < ActiveRecord::Base
  attr_accessible :reservation_id, :reservation_date_id, :price, :room_id

  belongs_to :reservation_date
  belongs_to :reservation
  belongs_to :room

  validates(:reservation_id,presence:true)
  validates(:reservation_date_id,presence:true)
  validates(:room_id,presence:true)
end

class RoomReservation < ActiveRecord::Base
  attr_accessible :reservation_id, :date_id, :price, :room_id

  validates(:reservation_id,presence:true)
  validates(:date_id,presence:true)
  validates(:room_id,presence:true)
end

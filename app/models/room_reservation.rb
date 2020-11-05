class RoomReservation < ActiveRecord::Base
  attr_accessible :reservation_id, :from_date_id, :to_date_id, :price, :room_id

  belongs_to :from_date, foreign_key: :from_date_id, class_name: ReservationDate
  belongs_to :to_date, foreign_key: :to_date_id, class_name: ReservationDate
  belongs_to :reservation
  belongs_to :room

  validates(:reservation_id,presence:true)
  validates(:from_date_id,presence:true)
  validates(:to_date_id,presence:true)
  validates(:room_id,presence:true)
end

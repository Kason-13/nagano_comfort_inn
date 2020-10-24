class Reservation < ActiveRecord::Base
  attr_accessible :client_id

  has_many :room_reservations
  belongs_to :client

  validates(:client_id, presence:true)
end

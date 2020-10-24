class Reservation < ActiveRecord::Base
  attr_accessible :client_id

  validates(:client_id, presence:true)
end

# == Schema Information
#
# Table name: rooms
#
#  id         :integer          not null, primary key
#  room_num   :integer
#  status     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Room < ActiveRecord::Base
  attr_accessible :room_num, :status

  # to make verify those criteria upon saves/updates
  validates(:room_num, presence:true)
  validates(:status, presence:true)
end

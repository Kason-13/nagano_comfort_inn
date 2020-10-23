# == Schema Information
#
# Table name: room_types
#
#  id         :integer          not null, primary key
#  room       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#



class RoomType < ActiveRecord::Base
  attr_accessible :price, :room

  validates(:room, presence: true)
end

# == Schema Information
#
# Table name: rooms
#
#  id           :integer          not null, primary key
#  room_num     :integer
#  status       :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  price        :decimal(, )
#  room_type_id :integer
#  view_type_id :integer
#


class Room < ActiveRecord::Base
  attr_accessible :room_num, :status, :price, :room_type_id, :view_type_id

  has_one :room_type
  has_one :view_type

  # to make verify those criteria upon saves/updates
  validates(:room_num, presence:true)
  validates(:status, presence:true)
  validates(:price,presence:true)
  validates(:room_type_id, presence:true)
  validates(:view_type_id,presence:true)
end
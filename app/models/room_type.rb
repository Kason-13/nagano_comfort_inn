class RoomType < ActiveRecord::Base
  attr_accessible :price, :room

  validates(:room, presence: true)
  validates(:price, presence: true)
end

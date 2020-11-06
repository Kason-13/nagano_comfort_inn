class RoomDisabledAttribute < ActiveRecord::Migration
  def change
    add_column :rooms, :deleted, :boolean
    remove_column :room_reservations, :price_modifier
  end
end

class MovePricesToRoomTable < ActiveRecord::Migration
  def change
    add_column :rooms, :price, :decimal
    remove_column :view_types, :price
    remove_column :room_types, :price
  end
end

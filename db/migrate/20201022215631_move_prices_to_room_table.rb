class MovePricesToRoomTable < ActiveRecord::Migration
  def change
    add_column :rooms, :price, :decimal
  end
end

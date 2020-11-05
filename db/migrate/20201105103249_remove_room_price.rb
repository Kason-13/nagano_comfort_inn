class RemoveRoomPrice < ActiveRecord::Migration
  def change
    remove_column :rooms, :price
  end
end

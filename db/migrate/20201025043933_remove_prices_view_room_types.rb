class RemovePricesViewRoomTypes < ActiveRecord::Migration
  def change
    remove_column :room_types, :price
    remove_column :view_types, :price
  end
end

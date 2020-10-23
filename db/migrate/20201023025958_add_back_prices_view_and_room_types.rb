class AddBackPricesViewAndRoomTypes < ActiveRecord::Migration
  def change
    add_column :room_types, :price, :decimal
    add_column :view_types, :price, :decimal
  end
end

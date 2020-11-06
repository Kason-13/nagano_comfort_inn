class RoomReservationWeekendPriceMod < ActiveRecord::Migration
  def change
    add_column :room_reservations, :weekend_price , :decimal
    add_column :room_reservations, :price_modifier , :decimal
  end
end

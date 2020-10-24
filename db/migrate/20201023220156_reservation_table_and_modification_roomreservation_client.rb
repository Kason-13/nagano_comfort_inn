class ReservationTableAndModificationRoomreservationClient < ActiveRecord::Migration
  def change
    remove_column :room_reservations, :client_id
    add_column :room_reservations, :reservation_id , :integer
  end
end

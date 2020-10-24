class ChangeReservationdateColumnName < ActiveRecord::Migration
  def change
    rename_column :room_reservations, :date_id, :reservation_date_id
  end
end

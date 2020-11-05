class ReservationDateFromDateToDate < ActiveRecord::Migration
  def change
    add_column :room_reservations, :from_date_id, :integer
    add_column :room_reservations, :to_date_id, :integer
    add_index :room_reservations, :from_date_id
    add_index :room_reservations, :to_date_id
  end
end

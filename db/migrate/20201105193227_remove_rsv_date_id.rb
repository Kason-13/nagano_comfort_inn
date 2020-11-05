class RemoveRsvDateId < ActiveRecord::Migration
  def change
    remove_column :room_reservations, :reservation_date_id
  end
end

class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :client_id

      t.timestamps
    end
    add_index :reservations, :client_id
    add_index :room_reservations, :date_id
    add_index :room_reservations, :room_id
    add_index :room_reservations, :reservation_id
  end
end

class CreateRoomReservations < ActiveRecord::Migration
  def change
    create_table :room_reservations do |t|
      t.integer :date_id
      t.integer :room_id
      t.integer :client_id
      t.decimal :price

      t.timestamps
    end
  end
end

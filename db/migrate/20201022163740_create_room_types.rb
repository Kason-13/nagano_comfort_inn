class CreateRoomTypes < ActiveRecord::Migration
  def change
    create_table :room_types do |t|
      t.string :room
      t.decimal :price

      t.timestamps
    end
    add_index :room_types, :room, unique: true
  end
end

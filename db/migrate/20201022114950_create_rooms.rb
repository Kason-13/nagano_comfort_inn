class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :room_num
      t.boolean :status

      t.timestamps
    end
  end
end

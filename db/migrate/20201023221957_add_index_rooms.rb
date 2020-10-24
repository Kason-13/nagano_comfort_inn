class AddIndexRooms < ActiveRecord::Migration
  def change
    add_index :rooms , :room_type_id
    add_index :rooms , :view_type_id
  end
end

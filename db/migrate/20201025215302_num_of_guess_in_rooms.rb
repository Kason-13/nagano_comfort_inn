class NumOfGuessInRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :num_of_guess, :integer
  end
end

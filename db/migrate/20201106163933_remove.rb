class Remove < ActiveRecord::Migration
  def change
    remove_column :rooms, :status
  end
end

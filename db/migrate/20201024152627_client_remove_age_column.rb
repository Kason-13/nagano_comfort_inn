class ClientRemoveAgeColumn < ActiveRecord::Migration
  def change
    remove_column :clients, :age
  end
end

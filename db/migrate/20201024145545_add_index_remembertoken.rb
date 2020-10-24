class AddIndexRemembertoken < ActiveRecord::Migration
  def change
    add_index :clients, :remember_token
  end
end

class AddPasswordColumnAddDemandsColumn < ActiveRecord::Migration
  def change
    add_column :clients, :password_digest, :string
    add_column :clients, :remember_token, :string
    add_column :reservations, :demands, :string
  end
end

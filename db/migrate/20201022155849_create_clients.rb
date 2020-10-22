class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :email
      t.integer :age

      t.timestamps
    end
    add_index :clients, :email, unique: true
  end
end

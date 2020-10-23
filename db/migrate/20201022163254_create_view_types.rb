class CreateViewTypes < ActiveRecord::Migration
  def change
    create_table :view_types do |t|
      t.string :view
      t.timestamps
    end
    add_index :view_types, :view, unique:true
  end
end

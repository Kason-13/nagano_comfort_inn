class CreatePriceModifiers < ActiveRecord::Migration
  def change
    create_table :price_modifiers do |t|
      t.string :name
      t.decimal :price

      t.timestamps
    end
  end
end

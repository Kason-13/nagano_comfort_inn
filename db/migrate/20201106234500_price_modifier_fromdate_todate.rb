class PriceModifierFromdateTodate < ActiveRecord::Migration
  def change
    add_column :price_modifiers, :from_date, :date
    add_column :price_modifiers, :to_date, :date
    add_index :price_modifiers, :from_date
    add_index :price_modifiers, :to_date
  end
end

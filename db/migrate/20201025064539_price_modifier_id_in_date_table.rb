class PriceModifierIdInDateTable < ActiveRecord::Migration
  def change
    remove_column :reservation_dates, :different_price
    add_column :reservation_dates, :price_modifier_id, :integer
    add_index :reservation_dates, :price_modifier_id
  end
end

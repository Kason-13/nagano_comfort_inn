class CreateWeekendPrices < ActiveRecord::Migration
  def change
    create_table :weekend_prices do |t|
      t.decimal :price

      t.timestamps
    end

    WeekendPrice.create :price => '0.00'
  end
end

class CreateReservationDates < ActiveRecord::Migration
  def change
    create_table :reservation_dates do |t|
      t.date :date
      t.boolean :weekend
      t.integer :different_price

      t.timestamps
    end
    add_index :reservation_dates, :date, unique:true
  end
end

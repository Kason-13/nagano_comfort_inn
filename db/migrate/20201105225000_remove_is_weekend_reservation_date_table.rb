class RemoveIsWeekendReservationDateTable < ActiveRecord::Migration
  def change
    remove_column :reservation_dates, :weekend
  end
end

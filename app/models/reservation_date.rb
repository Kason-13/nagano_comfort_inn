require 'date'
class ReservationDate < ActiveRecord::Base
  attr_accessible :date, :different_price, :weekend

  validates(:date, presence:true)

  before_save { weekend = set_weekend }

  private
    # to check if the date selected is a weekend
    def set_weekend
      selectedDate = Date.parse(date)
      isWeekend = false
      if selectedDate.saturday? || selectedDate.sunday?
        isWeekend = true
      end
      isWeekend
    end
end

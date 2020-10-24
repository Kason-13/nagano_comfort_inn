require 'date'
class ReservationDate < ActiveRecord::Base
  attr_accessible :date, :different_price, :weekend

  has_many :room_reservations

  validates(:date, presence:true)

  before_save { set_weekend }

  private
    # to check if the date selected is a weekend
    def set_weekend
      # selectedDate = Date.parse(date)
      weekend = false
      if date.saturday? || date.sunday?
        weekend = true
      end
      nil
    end
end

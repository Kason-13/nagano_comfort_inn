require 'date'
class ReservationDate < ActiveRecord::Base
  attr_accessible :date, :different_price, :weekend

  has_many :room_reservations
  belongs_to :price_modifier

  validates(:date, presence:true)

  before_save :set_weekend

  private
    # to check if the date selected is a weekend
    def set_weekend
      # selectedDate = Date.parse(date)
      self.weekend = nil
      if date.saturday? || date.sunday?
        self.weekend = true
      end
    end
end

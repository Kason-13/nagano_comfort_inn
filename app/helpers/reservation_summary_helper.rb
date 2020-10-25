module ReservationSummaryHelper

  def total_price(reservations)
    total = 0
    reservations.each do |reservation|
      total += reservation.price
    end
    total
  end

  def night_counts(reservations)
    reservations.length()
  end

end

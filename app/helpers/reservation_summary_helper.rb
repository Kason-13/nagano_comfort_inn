module ReservationSummaryHelper
  def display_reservation_total_price(reservations)
    total = 0
    reservations.each do |reservation|
      total += reservation.first.price
    end
    total
  end

  def display_night_counts(reservations)
    ((reservations.first.to_date.date - reservations.first.from_date.date)+1).to_i
  end

end

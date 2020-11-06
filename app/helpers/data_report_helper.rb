require 'date'
module DataReportHelper

  def display_occupied_rooms_numbers(rooms)
    unoccupied_rooms = []
    rooms.each do |room|
      unoccupied_rooms.push(room.room.room_num)
    end
    unoccupied_rooms.join(',')
  end

  def display_revenu_of_day(reservations)
    today = Date.today
    total = 0
    reservations.each do |reservation|
      total += reservation.room.view_type.price
      total += reservation.room.room_type.price
      if(today.saturday? || today.sunday?)
        total += reservation.weekend_price
      end
    end
    total
  end

end

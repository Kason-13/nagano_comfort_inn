require 'date'
module RoomDisplayHelper
  def display_availability(availability_in_bool)
    availability_str = " is currently "
    if availability_in_bool
      availability_str + "available"
    else
      availability_str + "unavailable or already reserved"
    end
  end

  def format_room_price(decimal_price)
    if(decimal_price.modulo(1) > 0.0)
      decimal_price
    else
      decimal_price.round
    end
  end

  def calc_total_price(from_date, to_date, room, price_modifiers, weekend_price)
    total = 0
    (from_date..to_date).each do |day|
      total += room.view_type.price
      total += room.room_type.price
      parsed_day = day.to_date
      if(parsed_day.saturday? || parsed_day.sunday?)
        total += weekend_price
      end
    end
    if(price_modifier.present?)
      price_modifier.each do |price|
        total += price
      end
    end
    total
  end

end

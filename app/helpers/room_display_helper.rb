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
end

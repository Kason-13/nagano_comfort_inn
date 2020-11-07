require 'date'
require 'pry'
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

  def format_checkout_date(date)
    date+1
  end

  #returns the number of days between two dates
  def display_days_between_dates(date1,date2)
    (Date.parse(date2)-Date.parse(date1)).to_i
  end

  #calculate total price to display for chosen dates
  def display_calc_total_price(from_date, to_date, room, price_modifiers, weekend_price)
    total = 0
    (Date.parse(from_date)..Date.parse(to_date)).each do |day|
      if day == Date.parse(to_date)
        break
      end
      total += room.view_type.price
      total += room.room_type.price
      parsed_day = day.to_date
      if(parsed_day.saturday? || parsed_day.sunday?)
        total += weekend_price
      end
    end
    if(price_modifiers.present?)
      price_modifiers.each do |price|
        total += price
      end
    end
    total
  end

  #for total price of suggested package
  def display_suggested_reservation_price(from_date, to_date, rooms, price_modifiers, weekend_price)
    total = 0
    rooms.each do |room|
      total += display_calc_total_price(from_date, to_date, room, price_modifiers, weekend_price)
    end
    total
  end

  #create list of rooms for multiple rooms reservations (suggested rooms package)
  #for reservation url
  def create_CSV_room_list(rooms)
    rooms_ls = []
    rooms.each do |room|
      rooms_ls.push(room.id)
    end
    rooms_ls.join(',')
  end

end

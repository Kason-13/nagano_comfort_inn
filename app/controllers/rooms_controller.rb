require 'pry'
class RoomsController < ApplicationController

  def search
    @checkin_date = params[:checkin_date]
    @checkout_date = params[:checkout_date]
    view_type_id = params[:view_type_selected]
    room_type_id = params[:room_type_selected]
    number_of_guess = params[:number_of_guess]
    number_of_rooms = params[:number_of_rooms]

    rooms_unavailable_ids = retrieve_unavailable_room_ids(@checkin_date,@checkout_date)
    #for some reason, it won't work if list is empty
    rooms_unavailable_ids.push(0)

    #retrieve rooms that are available and paginate
    @rooms = Room.where("id NOT IN (?) AND room_type_id = (?) AND view_type_id = (?)",
                        rooms_unavailable_ids, room_type_id, view_type_id)
                        .paginate(page: params[:page], per_page:5)

    rooms_recommandations = Room.where("id NOT IN (?) AND room_type_id = (?) AND view_type_id = (?) AND num_of_guess <= (?)",
                            rooms_unavailable_ids, room_type_id, view_type_id,number_of_guess)

    optimal_ls = return_optimal_room_choices(number_of_rooms,number_of_guess,rooms_recommandations)

    @rooms_recommanded = []
    optimal_ls.each do |room_index|
      @rooms_recommanded.push(rooms_recommandations[room_index])
    end

    price_modifiers_ids = ReservationDate.where(["date BETWEEN ? AND ?",@checkin_date,@checkout_date]).pluck(:price_modifier_id)

    @price_modifiers = PriceModifier.where("id IN (?)",price_modifiers_ids).pluck(:price)

    @weekend_price = WeekendPrice.first.price
    @room_types = RoomType.all
    @view_types = ViewType.all
  end

  def show
    @room = Room.find(params[:id])
  end

  def index
    @rooms = Room.paginate(page: params[:page], per_page:5)
    @room_types = RoomType.all
    @view_types = ViewType.all
  end

  private

    #method that returns a list of unavailable room ids list
    #params checkin and checkout dates
    def retrieve_unavailable_room_ids(checkin_date,checkout_date)
      # fetch records of dates that are between the checkin and checkout date
      dates_booked_ids = ReservationDate.where(["date BETWEEN ? AND ?",checkin_date,checkout_date]).pluck(:id) # problem here
      #for some reason, it won't work if list is empty
      dates_booked_ids.push(0)


      # fetch the rooms that are gonna be unavailable using the dates_booked_ids
      Room.joins(:room_reservations).where("reservation_date_id IN (?)",dates_booked_ids).pluck(:id)
    end

    def return_optimal_room_choices(number_of_rooms,number_of_guess,rooms)
      number_of_rooms = number_of_rooms.to_i
      number_of_guess = number_of_guess.to_i

      rooms_of = number_of_guess/number_of_rooms
      extra = number_of_guess%rooms_of
      rooms_capacities = rooms.pluck(:num_of_guess)
      optimal_rooms = []
      if(extra != 0)
        number_of_rooms-=1
        room_index = append_room_or_alternative(rooms_capacities,extra+rooms_of)
        rooms_capacities[room_index] = 0
        optimal_rooms.push(room_index)
      end

      for i in 0..number_of_rooms-1
        room_index = append_room_or_alternative(rooms_capacities,rooms_of)
        rooms_capacities[room_index] = 0
        optimal_rooms.push(room_index)
      end

      optimal_rooms
    end

    def append_room_or_alternative(rooms_capacities,rooms_of)
      room_index = nil
      if(rooms_capacities.include?(rooms_of))
        index = rooms_capacities.index(rooms_of)
        room_index = index
        rooms_capacities[index] = 0
      else
        alternative = rooms_of + 1
        if(alternative <= rooms_capacities.max)
          for n in alternative..rooms_capacities.max
            if(rooms_capacities.include?(n))
              index = rooms_capacities.index(n)
              room_index = index
              break
            end
          end
        end
      end
      room_index
    end

end

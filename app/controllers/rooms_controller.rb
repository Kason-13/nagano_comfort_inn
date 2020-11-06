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

    #list used for optimal room choices
    rooms_recommandations = Room.where("id NOT IN (?) AND room_type_id = (?) AND view_type_id = (?)",
                            rooms_unavailable_ids, room_type_id, view_type_id)
                            
    #list of room that responds to criterias
    optimal_ls = return_optimal_room_choices(number_of_rooms.to_i,number_of_guess.to_i,rooms_recommandations)

    @rooms_recommanded = []
    optimal_ls.each do |room_index|
      @rooms_recommanded.push(rooms_recommandations[room_index])
    end

    price_modifiers_ids = ReservationDate.where(["date BETWEEN ? AND ?",@checkin_date,@checkout_date]).pluck(:price_modifier_id)

    @price_modifiers = PriceModifier.where("id IN (?)",price_modifiers_ids).pluck(:price)

    if(WeekendPrice.first.nil?)
      WeekendPrice.create :price => '0.00'
    end
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
      dates_ids = ReservationDate.where(["date BETWEEN ? AND ?",checkin_date,checkout_date]).pluck(:id)
      #for some reason, it won't work if list is empty
      dates_ids.push(0)

      # fetch the rooms that are gonna be unavailable using the dates_booked_ids
      Room.joins(:room_reservations).where("(from_date_id IN (?)) or to_date_id IN (?)",dates_ids,dates_ids).pluck(:id)
    end

    #method that returns a list of index for room recommanded based on the client's criterias
    def return_optimal_room_choices(number_of_rooms,number_of_guess,rooms)
      number_of_rooms = number_of_rooms.to_i
      number_of_guess = number_of_guess.to_i

      rooms_of = number_of_guess/number_of_rooms
      extra = number_of_guess%rooms_of
      rooms_capacities = rooms.pluck(:num_of_guess)
      optimal_rooms = []

      # if an extra room is necessary
      if(extra != 0)
        number_of_rooms-=1
        room_index = append_room_or_alternative(rooms_capacities,extra+rooms_of)
        #returns an empty list if no possibilities are found
        if(room_index.nil?)
          return []
        end
        rooms_capacities[room_index] = 0
        optimal_rooms.push(room_index)
      end

      #for each rooms
      for i in 0..number_of_rooms-1
        room_index = append_room_or_alternative(rooms_capacities,rooms_of)
        #returns an empty list if no possibilities are found
        if(room_index.nil?)
          return []
        end
        rooms_capacities[room_index] = 0
        optimal_rooms.push(room_index)
      end

      optimal_rooms
    end

    #looks for the room that responds to the guess capacity need
    #returns the index of the room, will return nil if nothing ideal is found
    def append_room_or_alternative(rooms_capacities,rooms_of)
      room_index = nil
      #checks if there's a perfect fit for # of guess
      if(rooms_capacities.include?(rooms_of))
        index = rooms_capacities.index(rooms_of)
        room_index = index
        rooms_capacities[index] = 0
      else
        # tries to find the closest fit by incrementing the # of guess
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

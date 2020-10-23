class RoomsController < ApplicationController

  def search
    checkin_date = params[:checkin_date]
    checkout_date = params[:checkout_date]

    # fetch records of dates that are between the checkin and checkout date
    dates_booked = ReservationDate.where(["? >= date AND ? <= date",checkin_date,checkout_date])
    dates_booked_ids = extract_ids(dates_booked)

    # fetch the rooms that are gonna be unavailable using the dates_booked
    rooms_unavailable = Room.joins(:room_reservations).where("date_id IN (?)",dates_booked_ids)
    rooms_unavailable_ids = extract_ids(rooms_unavailable)

    #retrieve rooms that are available and paginate
    @rooms = Room.where("id NOT IN (?)",rooms_unavailable_ids).paginate(page: params[:page], per_page:5)
    @room_types_hashmap = hashmap_of_view_or_room_type_ls(create_roomType_list)
    @view_types_hashmap = hashmap_of_view_or_room_type_ls(create_viewType_list)

    #render page index which shows the available rooms
    render 'index'
  end

  def show
    @room = Room.find(params[:id])
  end

  def index
    @rooms = Room.paginate(page: params[:page], per_page:5)
    @room_types_hashmap = hashmap_of_view_or_room_type_ls(create_roomType_list)
    @view_types_hashmap = hashmap_of_view_or_room_type_ls(create_viewType_list)
  end

  def edit
  end

  def updated
  end

  def create
    @room = Room.new(params[:room])
    if(@room.save)
      redirect_to @room
    else
      render 'new'
    end
  end

  def new
    @room = Room.new
    @view_types_ls = create_viewType_list
    @room_types_ls = create_roomType_list
  end


  def destroy
  end

end

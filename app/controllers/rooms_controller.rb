require 'pry'
class RoomsController < ApplicationController
  before_filter :admin_only_action, only: [:edit,:create,:new]

  def search
    @checkin_date = params[:checkin_date]
    @checkout_date = params[:checkout_date]
    view_type_id = params[:view_type_selected]
    room_type_id = params[:room_type_selected]


    rooms_unavailable_ids = retrieve_unavailable_room_ids(@checkin_date,@checkout_date)

    #retrieve rooms that are available and paginate
    @rooms = Room.where("id NOT IN (?) AND room_type_id = (?) AND view_type_id = (?)",
                        rooms_unavailable_ids,room_type_id,view_type_id)
                        .paginate(page: params[:page], per_page:5)

    @room_types_hashmap = hashmap_of_view_room_type_ls(create_roomType_list)
    @view_types_hashmap = hashmap_of_view_room_type_ls(create_viewType_list)
  end

  def show
    @room = Room.find(params[:id])
  end

  def index
    @rooms = Room.paginate(page: params[:page], per_page:5)
    @room_types_hashmap = hashmap_of_view_room_type_ls(create_roomType_list)
    @view_types_hashmap = hashmap_of_view_room_type_ls(create_viewType_list)
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

  private

    #method that returns a list of unavailable room ids list
    #params checkin and checkout dates
    def retrieve_unavailable_room_ids(checkin_date,checkout_date)
      # fetch records of dates that are between the checkin and checkout date
      dates_booked = ReservationDate.where(["date BETWEEN ? AND ?",checkin_date,checkout_date]) # problem here
      dates_booked_ids = extract_ids(dates_booked)

      # fetch the rooms that are gonna be unavailable using the dates_booked
      rooms_unavailable = Room.joins(:room_reservations).where("reservation_date_id IN (?)",dates_booked_ids)
      extract_ids(rooms_unavailable)
    end

end

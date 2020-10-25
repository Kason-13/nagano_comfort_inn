require 'pry'
class RoomsController < ApplicationController

  def search
    @checkin_date = params[:checkin_date]
    @checkout_date = params[:checkout_date]
    view_type_id = params[:view_type_selected]
    room_type_id = params[:room_type_selected]


    rooms_unavailable_ids = retrieve_unavailable_room_ids(@checkin_date,@checkout_date)
    #for some reason, it won't work if list is empty
    rooms_unavailable_ids.push(0)

    #retrieve rooms that are available and paginate
    @rooms = Room.where("id NOT IN (?) AND room_type_id = (?) AND view_type_id = (?)",
                        rooms_unavailable_ids, room_type_id, view_type_id)
                        .paginate(page: params[:page], per_page:5)

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

end

class RoomReservationsController < ApplicationController
  def show
  end

  def index
    @reservations = RoomReservation.paginate(page: params[:page])
  end

  def new
    @room_id = params[:id]
    @room = Room.find_by_id(@room_id)
    @room_types_hashmap = hashmap_of_view_or_room_type_ls(create_roomType_list)
    @view_types_hashmap = hashmap_of_view_or_room_type_ls(create_viewType_list)
  end

  def create
    checkin_date = Date.parse(params[:checkin_date])
    checkout_date = Date.parse(params[:checkout_date])

    if Client.where(:email => params[:form_email]).blank?
      new_client = Client.new(name: params[:form_name], email: params[:form_email])
      new_client.save!
    end
    client = Client.where(:email => params[:form_email])

    (checkin_date..checkout_date).each do |day|
      if ReservationDate.where(:date => day).blank?
        new_reservation_date = ReservationDate.new(date:day)
        new_reservation_date.save!
        new_room_reservation = RoomReservation.new(date_id:new_reservation_date.id , room_id: params[:id], client_id: client.id )
        new_room_reservation.save!
      else
        found_date = ReservationDate.where(:date => day)
        new_room_reservation = RoomReservation.new(date_id:found_date.id , room_id: params[:id], client_id: client.id )
        new_room_reservation.save!
      end
    end

  end

  def destroy
  end

  def edit
  end

end

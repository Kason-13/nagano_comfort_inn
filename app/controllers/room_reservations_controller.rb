require 'pry'
class RoomReservationsController < ApplicationController
  def show
  end

  def index
    @reservations = RoomReservation.find(:all,:joins=>"
                                                      JOIN reservation_dates ON reservation_dates.id = room_reservations.date_id
                                                      JOIN rooms ON rooms.id = room_reservations.room_id
                                                      JOIN reservations ON reservations.id = room_reservations.reservation_id
                                                      JOIN clients ON client.id = reservation.client_id")
    # ehhhh .... probably better to join the tables together
    #  at this point, I'll do this later when I can
    dates_hash = {}
    ReservationDate.all.each do |date|
      dates_hash[date.id] = date.date
    end
    rooms_hash = {}
    Room.all.each do |room|
      rooms_hash[room.id] = room.room_num
    end
    clients_name_hash = {}
    Client.all.each do |client|
      clients_name_hash[client.id] = client.name
    end
    reservation_ids_hash = {}
    Reservation.all.each do |reservation|
      reservation_ids_hash[reservation.id] = reservation.client_id
    end
    @clients = clients_name_hash
    @rooms = rooms_hash
    @dates = dates_hash
    @reservation_ids = reservation_ids_hash
    ##################################################################################################
  end

  def new
    @room_id = params[:id]
    @room = Room.find_by_id(@room_id)
    @room_types_hashmap = hashmap_of_view_room_type_ls(create_roomType_list)
    @view_types_hashmap = hashmap_of_view_room_type_ls(create_viewType_list)
  end

  def create
    checkin_date = Date.parse(params[:checkin_date])
    checkout_date = Date.parse(params[:checkout_date])

    client = create_or_find_client(params[:form_email],params[:form_name])

    reservation = create_reservation_id(client.id)

    (checkin_date..checkout_date).each do |day|
      make_reservation(day,reservation.id,params[:id])
    end

    redirect_to rooms_path # for now, need to make a resume of their reservation
  end

  def destroy
  end

  def edit
  end

  private
    # method to find existing client in the DB if it exists. will create it if not
    def create_or_find_client(email,name)
      if Client.where(:email => email).blank?
        new_client = Client.new(name: name, email: email)
        new_client.save!
      end
      Client.where(:email => email).first
    end

    def create_reservation_id(client_id)
      new_reservation_id = Reservation.new(client_id:client_id)
      new_reservation_id.save!
      new_reservation_id
    end

    # method that will create the room reservation and the date of the reservation if it's not already in the DB
    def make_reservation(day,reservation_id,room_id)
      if ReservationDate.where(:date => day).blank?
        new_reservation_date = ReservationDate.new(date:day)
        new_reservation_date.save!
      end
      found_date = ReservationDate.where(:date => day).first
      new_room_reservation = RoomReservation.new(date_id:found_date.id , room_id: room_id, reservation_id: reservation_id )
      new_room_reservation.save!
    end

end

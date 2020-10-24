require 'pry'
require 'will_paginate/array'
class RoomReservationsController < ApplicationController
  before_filter :admin_only_action, only: [:index]

  def index
    all_reservation_ids = Reservation.all
    @reservations = []
    #fetch the data of the first and last day of reservation (mostly doing that for the checkin and checkout dates)
    all_reservation_ids.each do |reservation|
      checkin_data = RoomReservation.where("reservation_id = (?)",reservation.id).order(:id)[0]
      checkout_data = RoomReservation.where("reservation_id = (?)",reservation.id).order(:id)[-1]
      @reservations.push([checkin_data,checkout_data])
    end
    @reservations = @reservations.paginate(page: params[:page], per_page:20)
  end

  def new
    @room_id = params[:id]
    @room = Room.find_by_id(@room_id)
    @room_types_hashmap = hashmap_of_view_room_type_ls(create_roomType_list)
    @view_types_hashmap = hashmap_of_view_room_type_ls(create_viewType_list)
  end

  def create
    if(params[:checkin_date].empty? || params[:checkout_date].empty?)
      #room_reservation_url(params[:id])
      #currently not functioning properly, idk why
    end

    checkin_date = Date.parse(params[:checkin_date])
    checkout_date = Date.parse(params[:checkout_date])


    client = create_or_find_client(params[:form_email],params[:form_name])

    reservation = create_reservation_id(client.id)

    (checkin_date..checkout_date).each do |day|
      make_reservation(day, reservation.id, params[:id])
    end

    redirect_to rooms_path # for now, need to make a resume of their reservation
  end

  private

    def room_reservation_url(room_id)
      '/room_reservation/new/'+room_id.to_s
    end

    # method to find existing client in the DB if it exists. will create it if not
    def create_or_find_client(email,name)
      email.downcase!
      if Client.where(:email => email).blank?
        new_client = Client.new(name: name, email: email)
        if(!new_client.save!)
          render 'new'
        end
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
        if(!new_reservation_date.save!)
          render 'new'
        end
      end
      found_date = ReservationDate.where(:date => day).first
      new_room_reservation = RoomReservation.new(reservation_date_id:found_date.id , room_id: room_id, reservation_id: reservation_id )
      if(!new_room_reservation.save!)
        render 'new'
      end
    end

end

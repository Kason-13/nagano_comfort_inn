require 'pry'
require 'will_paginate/array'
class RoomReservationsController < ApplicationController
  before_filter :signed_in_client, only: [:new,:create,:client_reservations]

  def my_reservations
    reservation_ids = Reservation.where("client_id = (?)",current_client.id)
    @reservations = []
    reservation_ids.each do |reservation|
      @reservations.push(
        [RoomReservation.where("reservation_id = (?)",reservation.id).order(:id)[0],
        RoomReservation.where("reservation_id = (?)",reservation.id).order(:id)[-1]])
    end
    @reservations = @reservations.paginate(page: params[:page], per_page:10)
  end

  def new
    @room_id = params[:id]
    @room = Room.find_by_id(@room_id)
    @room_type = RoomType.where("id = (?)",@room.room_type_id).first
    @view_type = ViewType.where("id = (?)",@room.view_type_id).first
  end

  def create
    if(params[:checkin_date].empty? || params[:checkout_date].empty?)
      #room_reservation_url(params[:id])
      #currently not functioning properly, idk why
    end

    checkin_date = Date.parse(params[:checkin_date])
    checkout_date = Date.parse(params[:checkout_date])
    #retrieve clients infos
    client = current_client

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

    def create_reservation_id(client_id)
      new_reservation_id = Reservation.new(client_id:client_id)
      new_reservation_id.save!
      new_reservation_id
    end

    # method that will create the room reservation and the date of the reservation if it's not already in the DB
    def make_reservation(day,reservation_id,room_id)
      if(ReservationDate.where(:date => day).blank?)
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

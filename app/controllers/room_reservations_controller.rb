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

    redirect_to '/reservation_summary/'+reservation.id.to_s
  end

  def reservation_summary
    @reservations = RoomReservation.where("reservation_id = (?)",params[:id])
    @client = Client.find_by_id(Reservation.find_by_id(params[:id]).client_id)
  end

  private

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
      price = calc_price(found_date,room_id)
      new_room_reservation = RoomReservation.new(reservation_date_id:found_date.id , room_id: room_id, reservation_id: reservation_id, price: price )
      if(!new_room_reservation.save!)
        render 'new'
      end
    end

    def calc_price(date,room_id)
      price = 0
      if(!date.weekend.nil?)
        if(WeekendPrice.first.nil?)
          WeekendPrice.create :price => '0.00'
        end
        price +=  WeekendPrice.first.price
      end
      price += ViewType.find_by_id(Room.find_by_id(room_id).view_type_id).price
      price += RoomType.find_by_id(Room.find_by_id(room_id).room_type_id).price
      if(!date.price_modifier_id.nil?)
        price += PriceModifier.find_by_id(date.price_modifier_id).price
      end
      price
    end

end

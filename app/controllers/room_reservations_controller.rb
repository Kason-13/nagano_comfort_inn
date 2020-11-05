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
    @room_ids = params[:ids].split(',')

    @rooms = Room.where("id IN (?)",@room_ids)
    @checkin_date = params[:checkin_date]
    @checkout_date = params[:checkout_date]
    @price_modifiers = PriceModifier.where("id IN (?)",
                                            ReservationDate.where(["date BETWEEN ? AND ?",@checkin_date,@checkout_date]).pluck(:price_modifier_id))
                                            .pluck(:price)
    @weekend_price = WeekendPrice.first.price
    @room_types = RoomType.where("id IN (?)",@rooms.pluck(:room_type_id))
    @view_types = ViewType.where("id IN (?)",@rooms.pluck(:view_type_id))
  end

  def create
    checkin_date = Date.parse(params[:checkin_date])
    checkout_date = Date.parse(params[:checkout_date])
    room_ids = params[:ids].split(',')

    #retrieve clients infos
    client = current_client

    #create room reservation of customer
    reservation = create_reservation_id(client.id)

    room_ids.each do |id|
      (checkin_date..checkout_date).each do |day|
        if(checkout_date == day)
          break
        end
        make_reservation(day, reservation.id, id)
      end
    end

    redirect_to '/reservation_summary/'+reservation.id.to_s
  end

  def reservation_summary
    room_ids = RoomReservation.where("reservation_id = (?)",params[:id]).pluck(:room_id).uniq
    @reservations = []
    room_ids.each do |id|
      @reservations.push(RoomReservation.where("reservation_id = (?) AND room_id = (?)",params[:id],id))
    end
    #binding.pry
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

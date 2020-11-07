require 'pry'
require 'will_paginate/array'
class RoomReservationsController < ApplicationController
  before_filter :signed_in_client, only: [:new,:create,:client_reservations]

  CHECKOUT_DATE_OFFSET = 1

  def my_reservations
    reservation_ids = Reservation.where("client_id = (?)",current_client.id)
    @reservations = RoomReservation.where("reservation_id IN (?)", reservation_ids)
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

    #checks if the rooms are avaiable for reservations,in case of user changing parameters
    room_ids.each do |room_id|
      if(!eval_reservation_request(checkin_date,checkout_date,room_id.to_i))
        flash[:error] = "one or more room isn't available at these dates"
        return redirect_to root_path
      end
    end

    #retrieve clients infos
    client = current_client
    #create room reservation of customer
    reservation = create_reservation_id(client.id,params[:demands])

    room_ids.each do |id|
      make_reservation(checkin_date, checkout_date-CHECKOUT_DATE_OFFSET, reservation.id, id)
    end
    redirect_to '/reservation_summary/'+reservation.id.to_s
  end

  def reservation_summary
    room_ids = RoomReservation.where("reservation_id = (?)",params[:id]).pluck(:room_id).uniq
    @reservations = []
    room_ids.each do |id|
      @reservations.push(RoomReservation.where("reservation_id = (?) AND room_id = (?)",params[:id],id)).first
    end
    @client = Client.find_by_id(Reservation.find_by_id(params[:id]).client_id)
  end

  private
    #method to verify if room is already reservated for date range
    #returns true or false
    def eval_reservation_request(checkin_date,checkout_date,room_id)
      reserv_eval = false
      unavailable_rooms_ids = RoomReservation.joins('JOIN reservation_dates AS from_dates ON room_reservations.from_date_id = from_dates.id').
                                 joins('JOIN reservation_dates AS to_dates ON room_reservations.to_date_id = to_dates.id').
                                 where('(?) BETWEEN from_dates.date AND to_dates.date OR (?) BETWEEN from_dates.date AND to_dates.date', checkin_date,checkout_date).
                                 pluck(:room_id)
      if(!unavailable_rooms_ids.include?(room_id))
        reserv_eval = true
      end
      reserv_eval
    end

    #creates a reservation id in the DB and returns it
    def create_reservation_id(client_id,demands)
      new_reservation = Reservation.new(client_id:client_id,demands:demands)
      new_reservation.save!
      new_reservation
    end

    # check if date exists in DB, creates it if it doesn't
    def check_reservation_dates_exist(day)
      if(ReservationDate.where(:date => day).blank?)
        new_reservation_date = ReservationDate.new(date:day)
        if(!new_reservation_date.save!)
          render 'new'
        end
      end
    end

    # method that will create the room reservation and the date of the reservation if it's not already in the DB
    def make_reservation(from_date,to_date,reservation_id,room_id)
      price = 0
      (from_date..to_date).each do |day|
        #checks and creates the date if needed
        check_reservation_dates_exist(day)
        reservation_date = ReservationDate.where(:date => day).first
        #for price of reservation
        price += calc_price(reservation_date,room_id)
      end
      new_room_reservation = RoomReservation.new(from_date_id:ReservationDate.where(:date => from_date).first.id,
                                                  to_date_id:ReservationDate.where(:date => to_date).first.id,
                                                  room_id: room_id,
                                                  reservation_id: reservation_id,
                                                  price: price,
                                                  weekend_price: WeekendPrice.first.price )
      if(!new_room_reservation.save!)
        render 'new'
      end
    end

    #method to calculate the price for the night
    def calc_price(date_infos, room_id)
      price = 0
      if(date_infos.date.saturday? || date_infos.date.sunday?)
        if(WeekendPrice.first.nil?)
          WeekendPrice.create :price => '0.00'
        end
        price +=  WeekendPrice.first.price
      end
      price += ViewType.find_by_id(Room.find_by_id(room_id).view_type_id).price
      price += RoomType.find_by_id(Room.find_by_id(room_id).room_type_id).price
      if(!date_infos.price_modifier_id.nil?)
        price += PriceModifier.find_by_id(date_infos.price_modifier_id).price
      end
      price
    end

end

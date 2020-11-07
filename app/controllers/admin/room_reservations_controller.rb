require 'will_paginate/array'
require 'pry'
class Admin::RoomReservationsController < Admin::BaseController
  before_filter :admin_only_action, only: [:index]

  CHECKOUT_OFFSET = 1

  def index
    @reservations = RoomReservation.paginate(page: params[:page], per_page:20)
  end

  def edit
    @reservation = RoomReservation.find_by_id(params[:id])
  end

  def update
    # new_checkin_date = Date.parse(params[:checkin_date])
    # new_checkout_date = Date.parse(params[:checkout_date])
    # #checks if dates are valid
    # if(params[:checkin_date].empty? || params[:checkout_date].empty?)
    #   return error_redirect("checkin and checkout dates cannot be empty",edit_admin_room_reservation_path(params[:id]))
    # elsif(new_checkin_date > new_checkout_date)
    #   return error_redirect("Range for dates are not valid for reservations",edit_admin_room_reservation_path(params[:id]))
    # end

    # current_reservation = RoomReservation.find_by_id(params[:id])
    #
    # #checks if we're able to update the dates
    # if(!can_update_dates(current_reservation.from_date.date, current_reservation.to_date.date, new_checkin_date, new_checkout_date, current_reservation.room.id))
    #   return error_redirect("There's already another reservation for that room at the specific date range",edit_admin_room_reservation_path(params[:id]))
    # end
    if(RoomReservation.find_by_id(params[:id]).update_attributes(params[:room_reservation]))
      flash[:success] = "Reservation succcessfuly modified"
      redirect_to admin_room_reservations_path
    else
      @reservation = RoomReservation.find_by_id(params[:id])
      flash.now[:error] = "some informations for the reservations are invalid"
      render 'edit'
    end

  end

  private
    #to check if we can update the dates
    def can_update_dates(checkin_date,checkout_date,new_checkin_date,new_checkout_date,room_id)
      can_update = true

      #get room ids that are already within those dates
      room_ids = RoomReservation.joins('JOIN reservation_dates AS from_dates ON room_reservations.from_date_id = from_dates.id').
                                 joins('JOIN reservation_dates AS to_dates ON room_reservations.to_date_id = to_dates.id').
                                 where('(?) BETWEEN from_dates.date AND to_dates.date OR (?) BETWEEN from_dates.date AND to_dates.date', new_checkin_date,new_checkout_date).
                                 pluck(:room_id)

      # if old date is inside new date, we want to remove one instance of the id from the list ids to check
      if(checkin_date <= new_checkin_date || checkout_date >= (new_checkout_date - CHECKOUT_OFFSET))
        room_ids.delete_at(room_ids.index(room_id))
      end

      #another reservation at new chosen date already exists?
      if(room_ids.include?(room_id))
        can_update = false
      end

      can_update
    end

end

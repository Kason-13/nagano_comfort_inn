require 'will_paginate/array'
require 'pry'
class Admin::RoomReservationsController < Admin::BaseController
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

end

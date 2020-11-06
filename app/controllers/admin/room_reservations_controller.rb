require 'will_paginate/array'
require 'pry'
class Admin::RoomReservationsController < Admin::BaseController
  before_filter :admin_only_action, only: [:index]

  def index
    @reservations = RoomReservation.paginate(page: params[:page], per_page:20)
  end

end

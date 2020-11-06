require 'date'
require 'pry'
class Admin::DataReportsController < Admin::BaseController
  before_filter :admin_only_action

  CHECKOUT_DATE_OFFSET = 1

  def index
    today_date = Date.today
    search_date = (today_date-CHECKOUT_DATE_OFFSET).to_s(:db)
    today_date_id = 0
    if(!ReservationDate.find_by_date(today_date).nil?)
      today_date_id = ReservationDate.find_by_date(today_date).id
    end
    @rooms_to_clean = RoomReservation.where("to_date_id = (?)",today_date_id)

    @occupied_rooms_reservations = []

    # @occupied_rooms = RoomReservation.joins('reservation_dates AS from_dates ON room_reservations.from_date_id = from_dates.id').
    #                                   joins('reservation_dates AS to_dates ON room_reservations.to_date_id = to_dates.id').
    #                                   where('(?) BETWEEN from_dates.date AND to_dates.date',search_date)

    search_date = today_date.to_s(:db)
    RoomReservation.all.each do |reservation|
      if(Date.parse(search_date) >= reservation.from_date.date && Date.parse(search_date) <= reservation.to_date.date)
        @occupied_rooms_reservations.push(reservation)
      end
    end

    @number_of_rooms = Room.all.length
  end

end

require 'date'
require 'pry'
class Admin::DataReportsController < Admin::BaseController
  before_filter :admin_only_action

  CHECKOUT_DATE_OFFSET = 1

  def index
    today_date = Date.today
    search_date = (today_date-CHECKOUT_DATE_OFFSET).to_s(:db)
    binding.pry
    today_date_id = 0
    if(!ReservationDate.find_by_date(today_date).nil?)
      today_date_id = ReservationDate.find_by_date(today_date).id
    end
    @rooms_to_clean = RoomReservation.where("to_date_id = (?)",today_date_id)
  end

end

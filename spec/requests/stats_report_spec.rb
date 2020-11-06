require 'spec_helper'
require 'date'

describe "stats report" do

  subject { page }

  describe "checks accessibility" do
    describe "when not in admin mode, it should redirect to home" do
      before {visit admin_data_reports_path}
      it { should have_selector('title',text:'Home') }
    end

    describe "when in admin mode, it should be accessible" do
      before do
        go_admin_mode
        visit admin_data_reports_path
      end
      it { should have_selector('title',text:'Stats reports') }
    end
  end

  describe "data shown" do
    before do
      @from_date = ReservationDate.new(date:Date.today-2)
      @to_date = ReservationDate.new(date:Date.today)
      @room = Room.new(room_num:1,view_type_id:1,room_type_id:1,num_of_guess:1)
      @room.save!
      @from_date.save!
      @to_date.save!
      @reservation = RoomReservation.new(reservation_id:1,from_date_id:@from_date.id,to_date_id:@to_date.id,room_id:@room.id)
      @reservation.save!

      @from_date2 = ReservationDate.new(date:Date.today+2)
      @to_date2 = ReservationDate.new(date:Date.today+3)
      @from_date2.save!
      @to_date2.save!
      @room2 = Room.new(room_num:2,view_type_id:1,room_type_id:1,num_of_guess:1)
      @room2.save!
      @reservation2 = RoomReservation.new(reservation_id:2,from_date_id:@from_date2.id,to_date_id:@to_date2.id,room_id:@room2.id)
      @reservation2.save!
    end

    describe "rooms that needs to be cleaned section" do
      before do
        go_admin_mode
        visit admin_data_reports_path
      end

      describe "It should show that room 1 needs to be cleaned" do
        it { should have_selector('.cleaning_room_number',text:'room #1') }
      end
    end

    describe "rooms occupation rate" do
      before do
        go_admin_mode
        visit admin_data_reports_path
      end
      describe "It should show the occupation rate for the day" do
        it { should have_selector('.occupation_rate',text:'1 room(s) occupied out of 2 available') }
      end
    end
  end

end

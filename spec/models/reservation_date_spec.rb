require 'spec_helper'

describe ReservationDate do

  let(:reservation_date) { FactoryGirl.create(:reservation_date) }

  subject{reservation_date}

  it { should respond_to(:date) }
  it { should respond_to(:weekend) }
  it { should respond_to(:different_price) }

  it { should be_valid }

  describe "verifying validity of informations" do
    describe "when date is empty" do
      before { reservation_date.date = nil }
      it { should_not be_valid }
    end
  end

end

require 'spec_helper'

describe RoomType do
  let(:room_type) { FactoryGirl.create(:room_type) }

  describe "verifying validations" do
    describe "when room type string is empty" do
      before { room_type.room = ' '}
      it { should_not be_valid }
    end

    describe "when room type price is null" do
      before { room_type.price = nil }
      it { should_not be_valid }
    end
  end

end

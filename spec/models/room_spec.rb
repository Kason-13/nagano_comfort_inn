# == Schema Information
#
# Table name: rooms
#
#  id           :integer          not null, primary key
#  room_num     :integer
#  status       :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  price        :decimal(, )
#  room_type_id :integer
#  view_type_id :integer
#

require 'spec_helper'

describe Room do
  before do
    @room = Room.new(room_num: 1,num_of_guess:2, deleted: false,room_type_id:1,view_type_id:1)
    @room.save!
  end

  subject { @room }

  it { should respond_to(:room_num) }

  it {should be_valid}

  describe "when fields are empty" do
    describe "when room_num is empty" do
      before { @room.room_num = nil }
      it { should_not be_valid }
    end

    describe "when room_type_id is empty" do
      before { @room.room_type_id = nil }
      it { should_not be_valid }
    end

    describe "when view_type_id is empty" do
      before { @room.view_type_id = nil }
      it { should_not be_valid }
    end
  end

end

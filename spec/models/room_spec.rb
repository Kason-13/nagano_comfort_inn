# == Schema Information
#
# Table name: rooms
#
#  id         :integer          not null, primary key
#  room_num   :integer
#  status     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Room do
  before do
    @room = Room.new(room_num: 1, status: true)
    @room.save!
  end

  subject { @room }

  it { should respond_to(:room_num) }
  it { should respond_to(:status) }

  it {should be_valid}

  describe "when room_num is empty" do
    before { @room.room_num = nil }
    it { should_not be_valid }
  end

  describe "when status is empty" do
    before { @room.status = nil }
    it { should_not be_valid }
  end

end

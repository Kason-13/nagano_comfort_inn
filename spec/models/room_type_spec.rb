# == Schema Information
#
# Table name: room_types
#
#  id         :integer          not null, primary key
#  room       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


require 'spec_helper'

describe RoomType do
  let(:room_type) { FactoryGirl.create(:room_type) }

  subject { room_type }

  it { should respond_to(:room) }

  describe "verifying validations" do
    describe "when room type string is empty" do
      before { room_type.room = ' '}
      it { should_not be_valid }
    end
  end

end

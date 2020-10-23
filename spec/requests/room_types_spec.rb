require 'spec_helper'

describe "room types pages" do

  subject { page }

  describe "visiting adding a new room type page" do
    before do
      visit new_room_type_path
    end
    it { should have_selector('title', text: " | Add room type")}
    describe "creating a new room type" do
      # room type not created when invalid informations
      describe "with invalid informations" do
        it "should not create a new room type" do
          expect { click_button "Create new room type" }.not_to change(RoomType,:count)
        end
      end
      # room type created when valid informations
      describe "with valid informations" do
        before do
          fill_in "room_type_price", with: "5.99"
          fill_in "room_type_room", with: "lorem room"
        end
        it "should create a new room type" do
          expect { click_button "Create new room type"}.to change(RoomType,:count).by(1)
        end
      end
    end

  end

end

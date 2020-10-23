require 'spec_helper'

describe "room types pages" do
  describe "visiting adding a new room type page" do
    before do
      visit new_room_type_path # ???
    end
    it { should have_selector('title',text: "Add room type")}
    it { should have_content("price?") }
    it { should have_content("Room type name?") }
  end
end

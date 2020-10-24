require 'spec_helper'

describe "view types page" do

  subject { page }

  describe "visiting adding a new view type page" do

    before do
      visit admin_path
      visit new_view_type_path
    end
    it { should have_selector('title', text: " | Add view type") }
    describe "creating a new room type" do
      describe "with invalid informations" do
        it "should not create a new view type" do
          expect { click_button "Create new view type" }.to_not change(ViewType,:count)
        end
      end

      describe "with valid informations" do
        before do
          fill_in "view_type_view", with: "lorem view"
          fill_in "view_type_price", with: "25"
        end
        it "should create a new view type" do
          expect { click_button "Create new view type"}.to change(ViewType,:count).by(1)
        end
      end
    end

  end

end

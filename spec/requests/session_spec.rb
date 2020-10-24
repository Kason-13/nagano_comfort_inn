require 'spec_helper'

describe "session" do

  describe "check if redirect works" do

    subject { page }

    before do
      visit room_reservations_path
    end
    describe "should redirect me back the home page (no admin access)" do
      it {should have_selector('title', text: "Home")}
    end
  end

  describe "when in admin mode" do
    subject { page }
    before do
      visit admin_path
    end

    describe "should not redirect when visiting protected actions" do
      before do
        visit room_reservations_path
      end
      it { should have_selector('title', text: "All reservations") }
    end
    describe "navbar should be in admin mode" do
      before do
        visit root_path
      end
      it { should have_selector('a', text: "View all reservations") }
      it { should_not have_selector('a', text: "Admin mode") }
    end
    describe "when logging off from admin mode" do
      before { visit logoff_admin_path }
      it { should_not have_selector('a', text: "View all reservations") }
      it { should have_selector('a', text: "Admin mode") }
    end
  end

end

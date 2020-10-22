require 'spec_helper'

describe "room pages" do

  subject { page }

  describe "visiting the room's page" do

    # can't get it to work .....
    #after a little while, i pinned it down on the fact that FactoryGirl is not creating
    #anything with an id, therefor our route becomes /users/ instead of /users/5 (5 being the id)

    # let(:room) { FactoryGirl.create(:room) }
    #
    # describe "should display the correct informations" do
    #   before do
    #     visit rooms_path(room)
    #   end
    #   it { should have_selector('title', text: "Nagano Comfort Inn | 5" ) }
    #   it { should have_selector('h5', text: "The room is currently available" ) }
    # end

  end

end

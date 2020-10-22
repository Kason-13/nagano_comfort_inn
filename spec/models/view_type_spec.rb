require 'spec_helper'

describe ViewType do
  let(:view_type) { FactoryGirl.create(:view_type) }

  describe "verifying validates criteria" do
    describe "when view type string is empty" do
      before { view_type.view = ' ' }
      it { should_not be_valid }
    end
    describe "when view price is null" do
      before { view_type.price = nil}
      it { should_not be_valid }
    end
  end

end

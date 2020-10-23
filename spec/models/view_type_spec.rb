# == Schema Information
#
# Table name: view_types
#
#  id         :integer          not null, primary key
#  view       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#



require 'spec_helper'

describe ViewType do
  let(:view_type) { FactoryGirl.create(:view_type) }

  describe "verifying validates criteria" do
    describe "when view type string is empty" do
      before { view_type.view = ' ' }
      it { should_not be_valid }
    end
  end

end

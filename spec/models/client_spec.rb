# == Schema Information
#
# Table name: clients
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  age        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Client do
  let(:client) { FactoryGirl.create(:client) }

  subject{client}

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:age) }

  it { should be_valid }

  describe "verifying validity of informations" do

    describe "when name is empty" do
      before { client.name = "" }
      it { should_not be_valid}
    end


    describe "when email is empty" do
      before { client.email = " "}
      it { should_not be_valid }
    end

    describe "when email format is invalid" do
      it "should be invalid" do
        addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                       foo@bar_baz.com foo@bar+baz.com]
        addresses.each do |invalid_address|
          client.email = invalid_address
          client.should_not be_valid
        end
      end
    end

  end

end

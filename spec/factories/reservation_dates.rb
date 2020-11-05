# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reservation_date do
    date "2020-10-23"
    weekend false
    price_modifier_id 1
  end
end

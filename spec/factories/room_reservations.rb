# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :room_reservation do
    date_id 1
    room_id 1
    client_id 1
    price "9.99"
  end
end

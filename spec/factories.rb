FactoryGirl.define do

  factory :room do
    room_num 5
    status true
    price 500.25
    view_type_id 1
    room_type_id 1
  end

  factory :client do
    name "arthax leGrand"
    email "arthax@gmail.com"
  end

end

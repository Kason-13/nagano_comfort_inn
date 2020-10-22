FactoryGirl.define do

  factory :room do
    room_num 5
    status true
  end

  factory :client do
    name "arthax lgrand"
    email "arthax@gmail.com"
    age 35
  end

end

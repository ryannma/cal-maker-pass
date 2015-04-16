FactoryGirl.define do
  factory :admin do
    user
    location
  end

  factory :item do 
    name "item_name"
    price 4.99
    quantity 2
    status "sell"
    kind "tools"
    association :location, factory: :location, name: "item's location"
  end

  factory :location do
    name "location_name"
  end

  factory :transaction do
    association :user, factory: :user
    admin
    purpose "blank" 
  end

  factory :user do
    first_name "first"
    last_name "last"
    sid 12345678
  end
end

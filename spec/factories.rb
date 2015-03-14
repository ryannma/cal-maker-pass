FactoryGirl.define do
  factory :admin do
    user
    location  
  end
end

FactoryGirl.define do
  factory :item do 
    name "item name"
    price 4.99
    quantity 2
    status "sell"
    mytype "tools"
    association :location, factory: :location, name: "item's location"
  end
end

FactoryGirl.define do 
  factory :location do
    name "location_name"
  end
end

FactoryGirl.define do
  factory :transaction do
    association :user, factory: :user
    admnin
    item
    mytype "sold"
    purpose "blank" 
  end
end

FactoryGirl.define do 
  factory :user do
    first_name "first"
    last_name "last"
    sid 12345678
  end
end


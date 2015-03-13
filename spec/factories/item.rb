FactoryGirl define do
  factory :item do 
    name "item name"
    price 4.99
    quantity 2
    status "sell"
    mytype "tools"
    association :location, factory: :location, name: "item's location"
  end
end

 
    
    

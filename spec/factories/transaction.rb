FactoryGirl define do
  factory :transaction do
    association :student, factory: :user
    admnin
    location
    item
    mytype "sold"
    purpose "blank" 
  end

namespace :db do
  desc "Create 100 items with random attributes"
  task :populate => :environment do
    require 'populator'
    require 'faker'
      Item.populate 23 do |item|
        item.name = Faker::Commerce.product_name
        item.quantity = Faker::Number.number(2)
        item.price = Faker::Commerce.price 
        item.kind = Faker::Commerce.department
        item.status = ['lend', 'sell', 'both'][rand(3)]
        puts item.name
      end
      puts 'All done'
  end
end
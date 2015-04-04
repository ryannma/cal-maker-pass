require 'spec_helper'

describe Item do
  # context "newly created item" do
  #   it "is valid with a name, price, quantity, type and location" do
  #     location = Location.new("CITRUS")
  #     item = Item.new(
  #     	name: 'Component',
  #     	price: 4.20,
  #     	quantity: 5,
  #       mytype: 'Sell',
  #       location: location)
  #     #item.valid.should == true
  #   end
  #   it "does not allow duplicate items in the same location" do
  #     location = Location.new("CITRUS")
  #     location2 = Location.new("Etch")
  #     item1 = Item.new(
  #     	name: 'component',
  #     	price: 4.20,
  #     	quantity: 5,
  #     	mytype: 'Sell', 
  #     	location: location)
  #     item2 = Item.new(
  #     	name: 'component', 
  #     	price: 4.20,
  #     	quantity: 5,
  #     	type: 'Sell',
  #     	location: location)
  #     #item.valid.should == false
  #   end
  # end
  it "should have a location" do
    item = FactoryGirl.create(:item)
    item.location.name.should == "item's location"
  end

  it "can have its location changed" do
    item = FactoryGirl.create(:item)
    location = FactoryGirl.create(:location)
    item.location=(location)
    item.location.name.should == "location_name"
  end

end

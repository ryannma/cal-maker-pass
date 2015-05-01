require 'spec_helper'

describe Item do
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

  it "should have the ability to sort by name" do
    itemA = FactoryGirl.create(:item, :name=>"itemA")
    itemB = FactoryGirl.create(:item, :name=>"itemB", :price=>0.01)
    itemC = FactoryGirl.create(:item, :name=>"itemC")
    items = [itemA, itemB, itemC]
    Item.sort(items, 'name', 'ascending')
    items[0].should == itemA
    Item.sort(items, 'price', 'ascending')
    items[0].should == itemB
  end
end

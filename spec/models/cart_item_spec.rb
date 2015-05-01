require 'spec_helper'

describe CartItem do
  it "should have quantity and item with appropriate values" do
    item = FactoryGirl.create(:item)
    cartItem = CartItem.new(item, 4)
    cartItem.price.should == item.price
    cartItem.name.should == item.name
    cartItem.item_id.should == item.id
    cartItem.to_s.should == "quantity: #{cartItem.quantity}, item: #{cartItem.name}"
  end
end

require 'spec_helper'

describe Cart do
  
  it "should have know when its empty" do
    cart = Cart.new()
    item1 = FactoryGirl.create(:item, :name=>"item1")
    cart.add_item(item1.id.to_s)
    cart.empty?.should == false
  end

  it "should be able to remove items" do
    cart = Cart.new()
    item1 = FactoryGirl.create(:item)
    cart.add_item(item1.id.to_s)
    cart.delete_item(item1.id.to_s)
    cart.empty?.should == true
  end

  it "should be able to clear cart" do
    cart = Cart.new()
    item1 = FactoryGirl.create(:item)
    cart.add_item(item1.id.to_s)
    cart.empty?.should == false
    user = FactoryGirl.create(:user)
    cart.user = user
    cart.clear
    cart.cart_items.should == nil
    cart.user.should == nil
    cart.comment.should == nil
  end

  it "should have a total price" do
    item1 = FactoryGirl.create(:item, :price => 1.5)
    item2 = FactoryGirl.create(:item, :price => 2.2)
    cart = Cart.new()
    cart.add_item(item1.id.to_s)
    cart.add_item(item1.id.to_s)
    cart.add_item(item2.id.to_s)
    cart.total.should == (item1.price*2 + item2.price)
  end
end

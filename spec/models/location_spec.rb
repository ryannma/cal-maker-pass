require "spec_helper"

describe Location do

  it "should have a unique name" do
    l = Location.new(:name => "my_name")
    l.name.should == "my_name"

    l2 = Location.new(:name => "my_name")
    #l2.should_not be_valid
  end

  it "should have a list of admins" do
    l = FactoryGirl.create(:location)
    u = FactoryGirl.create(:user, :first_name => "first", :last_name => "last", :sid => 12345678)
    u2 = FactoryGirl.create(:user, :first_name => "first2", :last_name => "last2", :sid => 22345678)
    
    a = FactoryGirl.create(:admin, :location => l)
    a.user = u
    a.save
    a2 = FactoryGirl.create(:admin, :location => l)
    a2.user = u2
    a2.save

    l.admins[0].location.should == l
    l.admins[1].location.should == l
  end

  it "should have a list of items" do
    l = FactoryGirl.create(:location)
    i1 = FactoryGirl.create(:item, name: "item1", location: l)
    i2 = FactoryGirl.create(:item, name: "item2", location: l)

    l.items[0].location.should == l
    l.items[1].location.should == l
  end

end

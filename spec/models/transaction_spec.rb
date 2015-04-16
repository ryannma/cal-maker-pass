require 'spec_helper'

describe Transaction do
  it "should have all it's required feilds" do
    t = FactoryGirl.create(:transaction)
    t.user.first_name.should == "first"
    t.user.last_name.should == "last"
    t.admin.location.name.should == "location_name"
    t.purpose.should == "blank"
  end

  it "should have a number of line items" do
    t = FactoryGirl.create(:transaction)
    l_item1 = FactoryGirl.create(:line_item)
    l_item2 = FactoryGirl.create(:line_item)
    l_item1.transaction = t
    l_item1.save
    l_item2.transaction = t
    l_item2.save
    t.line_items[0].should == l_item1
    t.line_items[1].should == l_item2
  end
end

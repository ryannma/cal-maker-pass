require 'spec_helper'

describe Transaction do
  it "should have all it's required feilds" do
    t = FactoryGirl.create(:transaction)
    t.user.first_name.should == "first"
    t.admin.location.name.should == "location_name"
    t.item.name.should == "item_name"
    t.kind.should == "sold"
    t.purpose.should == "blank"
  end
end

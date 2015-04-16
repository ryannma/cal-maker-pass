require 'spec_helper'

describe Transaction do
  it "should have all it's required feilds" do
    t = FactoryGirl.create(:transaction)
    t.user.first_name.should == "first"
    t.user.last_name.should == "last"
    t.admin.location.name.should == "location_name"
    t.purpose.should == "blank"
  end
end

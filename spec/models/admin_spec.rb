require "spec_helper"

describe Admin do
  it "should have a user and location" do
    user = FactoryGirl.create(:user)
    loc = FactoryGirl.create(:location)
    admin = FactoryGirl.create(:admin)
    admin.location = loc
    admin.user = user
    admin.save
    admin.user.should == user
    admin.location.should == loc
  end
end

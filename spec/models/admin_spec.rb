require "spec_helper"

describe Admin do
  it "should have a user and location" do
    user = FactoryGirl.create(:user)
    loc = FactoryGirl.create(:location)
    admin = FactoryGirl.create(:admin, :user=> user, :location => loc)
    admin.user.should == user
    admin.location.should == loc
  end
end

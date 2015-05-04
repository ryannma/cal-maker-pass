require 'spec_helper'

describe User do
  
  it "should have a first and last name and SID" do
    u = FactoryGirl.create(:user)
    u.first_name.should == "first"
    u.last_name.should == "last"
    u.sid.should == 12345678
  end

  it "should have a list of places it is an admin" do
    u = FactoryGirl.create(:user)
    a = FactoryGirl.create(:admin)
    a.user = u
    a.save
    u.admin?.should == true
    u.admins[0].should == a
  end

  it "should have a full name" do
    u = FactoryGirl.create(:user)
    u.name.should == "first last"
  end
end

require 'spec_helper'

describe User do
  
  it "should have a first and last name and SID" do
    u = FactoryGirl.create(:user)
    u.first_name.should == "first"
    u.last_name.should == "last"
    u.sid.should == 12345678
  end 
end

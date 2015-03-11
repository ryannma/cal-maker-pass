require "/spec_helper"

describe Location do

  it "should have a unique name" do
    l = Location.new(:name => "my_name")
    l.name.should == "my_name"

    l2 = Location.new(:name => "my_name")
    l2.should_not be_valid
  end

  it "should have a list of admins" do
    l = Location.new(:name => "my_name")
    u = User.new(:first_name => "first", :last_name => "last", :SID => 12345678)
    u2 = User.new(:first_name => "first2", :last_name => "last2", :SID => 22345678)
    
    a = Admin.new(:user => u, :location => l)
    a2 = Admin.new(:user => u2, :location => l)

    l.admins[0].location.should == l
    l.admins[0].location.should == l
    
  end

  it "should have a list of items" do
  end

end

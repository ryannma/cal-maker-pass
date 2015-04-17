require 'spec_helper'
require 'sunspot/rails/spec_helper'

describe Item do
  it "should have a location" do
    item = FactoryGirl.create(:item)
    item.location.name.should == "item's location"
  end

  it "can have its location changed" do
    item = FactoryGirl.create(:item)
    location = FactoryGirl.create(:location)
    item.location=(location)
    item.location.name.should == "location_name"
  end

end

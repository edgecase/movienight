require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Night do
  it "should create a new instance given valid attributes" do
    Factory(:night).save.should == true
  end

  it "generates an invitee salt before create" do
    night = Night.new(Factory.attributes_for(:night))
    night.invitee_salt.should be_blank
    night.save!
    night.invitee_salt.should_not be_blank
  end
end

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Invitee do
  it "should create a new instance given valid attributes" do
    Factory.create(:invitee).should be_true
  end

  it "generates an access hash before create" do
    invitee = Factory.build(:invitee)
    invitee.access_hash.should be_blank
    invitee.save!
    invitee.access_hash.should_not be_blank
  end
end

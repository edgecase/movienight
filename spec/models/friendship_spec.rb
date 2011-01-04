require 'spec_helper'

describe Friendship do
  it "should not save when a user attemps to friend itself" do
    user = Factory(:user)
    Friendship.new(:user => user, :friend => user).save.should be_false
  end

  it "should keep a count of how many times it has been invited" do
    friendship = Factory(:friendship)
    friendship.invited_count.should == 0
    friendship.invite!
    friendship.invited_count.should == 1
    friendship.reload
    friendship.invited_count.should == 1
  end
end

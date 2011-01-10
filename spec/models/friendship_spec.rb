require 'spec_helper'

describe Friendship do
  it "should not save when a user attemps to friend itself" do
    user = Factory(:user)
    friendship = Friendship.new(:user => user, :friend => user)
    friendship.save.should be_false
    friendship.errors[:base].join('').should match(/Cannot add oneself/)
  end
end

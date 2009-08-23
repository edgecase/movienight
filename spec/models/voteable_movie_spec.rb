require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe VoteableMovie do
  before(:each) do
    @valid_attributes = {
      :night_id => 1,
      :movie_id => 1,
      :votes => 1
    }
  end

  it "should create a new instance given valid attributes" do
    VoteableMovie.create!(@valid_attributes)
  end
end

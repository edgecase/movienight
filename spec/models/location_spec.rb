require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Location do
  it "should create a new instance given valid attributes" do
    Factory(:location).save.should be_true
  end
end

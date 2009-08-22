require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Night do
  it "should create a new instance given valid attributes" do
    Factory(:night).save.should == true
  end
end

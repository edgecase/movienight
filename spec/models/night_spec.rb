require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Night do
  before(:each) do
    @valid_attributes = {
      :curtain_time_at => Time.now,
      :doors_open_at => Time.now,
      :host_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Night.create!(@valid_attributes)
  end
end

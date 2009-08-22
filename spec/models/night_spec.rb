require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Night do
  before do
    User.destroy_all
  end

  it "should create a new instance given valid attributes" do
    Factory(:night).save.should == true
  end

  it "should compose doors_open_at from date and time" do
    time = Time.now
    date = Date.today
    night = Factory(:night, :doors_open_time => time, :doors_open_date => date)
    night.doors_open_at.should == "#{date.to_s(:date)}, #{time.to_s(:time)}"
  end
end

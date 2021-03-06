require 'spec_helper'

describe Location do
  it "should create a new instance given valid attributes" do
    Factory(:location).save.should be_true
  end

  describe "#to_s" do
    it "should join fields with a comma" do
      Factory.build(:location).to_s.should match(/\d+ Any St., Columbus OH/)
    end
  end
end

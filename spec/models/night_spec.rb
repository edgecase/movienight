require 'spec_helper'

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

  describe "#send_invitations" do
    before do
      @user1 = Factory(:user, :email => "user1@example.com")
      @user2 = Factory(:user, :login => "user2", :email => "user2@example.com")
      @night = Factory(:night)
    end

    it "does not blow up when passed nil" do
      proc { @night.send_invitations nil }.should_not raise_error
    end

    describe "when emails do not have associated user accounts" do
      before do
        @mail = stub(:deliver => true)
        Notifier.stub!(:nonmember_invitation => @mail)
      end

      it "creates invitees for each email" do
        @night.send_invitations "nonreg1@foobars.com; nonreg2@goober.com"
        @night.invitees.count.should == 2
      end

      it "sends the non-member invitation" do
        Notifier.should_receive(:nonmember_invitation).twice
        @night.send_invitations "nonreg1@foobars.com; nonreg2@goober.com"
      end
    end
  end

end

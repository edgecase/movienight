require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

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

  describe "#invitiation_emails" do
    before do
      @user1 = Factory(:user, :email => "user1@example.com")
      @user2 = Factory(:user, :login => "user2", :email => "user2@example.com")
      @night = Factory(:night)
    end

    describe "when emails have associated user accounts" do
      it "sends the registered member invite email" do
        Notifier.should_receive(:deliver_registered_member_invitation).with(@user1, @night)
        Notifier.should_receive(:deliver_registered_member_invitation).with(@user2, @night)
        @night.invitiation_emails = 'user1@example.com,user2@example.com'
      end
    end

    describe "when emails do not have associated user accounts" do
      before do
        Notifier.stub! :deliver_nonmember_invitation
      end

      it "creates invitees for each email" do
        @night.invitiation_emails = "nonreg1@foobars.com; nonreg2@goober.com"
        @night.invitees.count.should == 2
      end

      it "sends the non-member invitation" do
        Notifier.should_receive(:deliver_nonmember_invitation).twice
        @night.invitiation_emails = "nonreg1@foobars.com; nonreg2@goober.com"
      end
    end
  end
end

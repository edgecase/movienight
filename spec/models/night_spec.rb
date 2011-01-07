require 'spec_helper'

describe Night do
  it "should create a new instance given valid attributes" do
    Factory(:night).save.should == true
  end

  it "generates an invitation salt before create" do
    night = Night.new(:host => Factory(:user))
    night.invitation_salt.should be_blank
    night.save(:validate => false)
    night.invitation_salt.should_not be_blank
  end

  describe "#send_invitations" do
    before do
      @user1 = Factory(:user, :email => "user1@example.com")
      @user2 = Factory(:user, :email => "user2@example.com")
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

      it "creates invitations for each email" do
        pending "Must rework how invites are sent"
        @night.send_invitations "nonreg1@foobars.com; nonreg2@goober.com"
        @night.invitations.count.should == 2
      end

      it "sends the non-member invitation" do
        pending "Must rework how invites are sent"
        Notifier.should_receive(:nonmember_invitation).twice
        @night.send_invitations "nonreg1@foobars.com; nonreg2@goober.com"
      end
    end
  end

  describe "#voted_on_by?" do
    let(:user)  { Factory :user }
    let(:night) { Factory :night }
    let(:movie) { Factory :movie }

    before do
      night.voteable_movies.create(:movie => movie)
      other_user = Factory(:user)

      night.voteable_movies.last.votes.create(:voter => other_user)
    end

    context "user's id appears in votes" do
      before do
        night.voteable_movies.last.votes.create(:voter => user)
      end

      it "returns true" do
        night.voted_on_by?(user).should be_true
      end
    end

    context "user's id does not appear in votes" do
      it "returns false" do
        night.voted_on_by?(user).should be_false
      end
    end
  end

end

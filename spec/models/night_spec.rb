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

      it "is true" do
        night.voted_on_by?(user).should be_true
      end
    end

    context "user's id does not appear in votes" do
      it "is false" do
        night.voted_on_by?(user).should be_false
      end
    end
  end

  describe "#voted_on_by?" do
    context "user is the host" do
      let(:user)  { Factory :user }
      let(:night) { Factory(:night, :host => user) }

      it "is true" do
        night.hosted_by?(user).should be_true
      end
    end

    context "user is not the host" do
      let(:user)  { Factory :user }
      let(:night) { Factory :night }

      it "is false" do
        night.hosted_by?(user).should be_false
      end
    end
  end

  describe "#invitees_include?" do
    context "user has an invite" do
      let(:user)  { Factory :user }
      let(:night) { Factory :night }

      before do
        night.invitations.build.tap do |invite|
          invite.invitee = user
        end.save!
      end

      it "is true" do
        night.invitees_include?(user).should be_true
      end
    end

    context "user does not have an invite" do
      let(:user)  { Factory :user }
      let(:night) { Factory :night }

      it "is false" do
        night.invitees_include?(user).should be_false
      end
    end
  end

  describe "#voters" do
    let(:night) { Factory :night }

    context "when there are no votes" do
      it "is an empty collection" do
        night.voters.should be_empty
      end
    end

    context "when there are votes" do
      let(:voters) { (1..5).map { Factory :user } }
      let(:voteable_movies) do
        (1..2).map { VoteableMovie.create(:night => night,
                                          :movie => Factory(:movie)) }
      end

      before do
        voters.each do |voter|
          voteable_movies[rand(2)].votes.create(:voter => voter)
        end
      end

      it "is each of the voters from the votes" do
        voters.each do |voter|
          night.voters.should include(voter)
        end
      end
    end
  end
end

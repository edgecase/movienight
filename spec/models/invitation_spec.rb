require 'spec_helper'

describe Invitation do
  let(:night)   { Factory(:night) }
  let(:invitee) { Factory(:invited_user) }

  describe "validation" do
    let(:invite) { Invitation.new }

    it "requires a night" do
      invite.should have(1).error_on(:night)
    end

    it "requires an invitee" do
      invite.should have(1).error_on(:invitee)
    end
  end

  context "before create" do
    it "generates an access hash" do
      invitation = Factory.build(:invitation)
      invitation.access_hash.should be_blank
      invitation.save!
      invitation.access_hash.should_not be_blank
    end
  end

  context "after create" do
  end

  describe "#to_param" do
    context "when the record is new" do
      it "is nil" do
        invite = Factory.build(:invitation)
        invite.to_param.should be_nil
      end
    end

    context "when the record is saved" do
      it "is the access_hash" do
        invite = Factory(:invitation)
        invite.to_param.should eql(invite.access_hash)
      end
    end
  end

  describe "#deliver" do
    let(:invitation) { Factory(:invitation) }
    let(:invitee)    { invitation.invitee }
    let(:email)      { stub.tap {|e| e.should_receive(:deliver)} }


    context "when an invitee" do
      before { invitee.invitee = true }
      it "sends a nonmember invitation" do
        Notifier.should_receive(:registered_member_invitation).never
        Notifier.should_receive(:nonmember_invitation).and_return(email)
        invitation.deliver
      end
    end

    context "when a regular user" do
      it "sends a member invitation" do
        Notifier.should_receive(:nonmember_invitation).never
        Notifier.should_receive(:registered_member_invitation).and_return(email)
        invitation.deliver
      end
    end
  end
end

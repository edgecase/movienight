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

  describe "#deliver" do
    let(:invitation) { Factory(:invitation) }
    let(:invitee)    { invitation.invitee }
    let(:email)      { stub.tap {|e| e.should_receive(:deliver)} }


    it "sends a nonmember invitation" do
      Notifier.should_receive(:night_invitation).and_return(email)
      invitation.deliver
    end
  end
end

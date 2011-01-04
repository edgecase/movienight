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
end

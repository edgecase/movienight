# -*- coding: utf-8 -*-
require 'spec_helper'

describe User do

  describe "validation" do
    context "when the user is an invitee" do
      let(:user) { User.new.tap {|u| u.invitee = true; u.save } }

      it "expects email" do
        user.errors[:email].should_not be_empty
      end

      it "does not expect name" do
        user.errors[:name].should be_empty
      end

      it "does not expect password" do
        user.errors[:password].should be_empty
      end
    end

    context "when the user has created or claimed their account" do
      let(:user) { User.new.tap {|u| u.valid? } }

      context "on creation" do
        it "expects password" do
          user.errors[:password].should_not be_empty
        end
      end

      it "expects email" do
        user.errors[:email].should_not be_empty
      end

      it "expects name" do
        user.errors[:name].should_not be_empty
      end
    end
  end

  describe ".find_user_or_create_invited_user" do
    let(:email) { "steve@foo.com" }

    context "when the email belongs to an existing user" do
      before do
        User.find_or_create_by_email(email) do |u|
          u.name = 'Steve'
          u.password = u.password_confirmation = 'password'
        end
      end

      it "returns the user" do
        user = User.find_user_or_create_invited_user(email)
        user.name.should == 'Steve'
        user.should_not be_an_invitee
      end
    end

    context "when the email does not belong to an existing user" do
      before do
        User.delete_all
      end

      it "returns a newly create invitee user" do
        user = User.find_user_or_create_invited_user(email)

        user.should be_an_invitee
        user.should be_persisted
      end
    end
  end

  context "friends" do
    it 'should have no friends to start with' do
      User.new.friends.should be_empty
    end
  end

  describe "#notify_of_invitation!" do
    let(:invitation) { Factory(:invitation) }
    let(:invitee)    { invitation.invitee }
    let(:email)      { stub.tap {|e| e.should_receive(:deliver)} }


    context "when an invitee" do
      before { invitee.invitee = true }
      it "sends a member invitation" do
        Notifier.should_receive(:nonmember_invitation).never
        Notifier.should_receive(:registered_member_invitation).and_return(email)
        invitee.notify_of_invitation!(invitation)
      end
    end

    context "when a regular user" do
      it "sends a member invitation" do
        Notifier.should_receive(:registered_member_invitation).never
        Notifier.should_receive(:nonmember_invitation).and_return(email)
        invitee.notify_of_invitation!(invitation)
      end
    end
  end
end

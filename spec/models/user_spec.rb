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
end

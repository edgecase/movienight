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

      it "generates an auth_token for that user" do
        user = User.find_user_or_create_invited_user(email)

        user.authentication_token.should_not be_nil
      end
    end
  end

  describe "#gravatar_url" do
    let(:email)  { "UserEmail@foo.com" }
    let(:digest) { Digest::MD5.hexdigest(email.downcase) }
    let(:user)   { Factory(:user, :email => email) }

    it "contains the MD5 hash of the user's downcased email" do
      url = user.gravatar_url
      url.should match(/avatar\/#{digest}/)
    end

    context "when a size is specified" do
      it "contains the size parameter" do
        url = user.gravatar_url(512)
        url.should match(/[&|?]s=512/)
      end
    end
  end

  context "friends" do
    it 'should have no friends to start with' do
      User.new.friends.should be_empty
    end
  end

  describe "#can_add_as_friend?" do
    context "when user is an invitee" do
      it "is false" do
        user = Factory(:user, :invitee => true)
        user.can_add_as_friend?(stub(:user)).should be_false
      end
    end

    context "when user has friends" do
      let(:user)   { Factory(:user) }
      let(:friend) { Factory(:user) }

      context "when potential friend is already a friend" do
        before { Friendship.create!(:user => user, :friend => friend) }
        it "is false" do
          user.can_add_as_friend?(friend).should be_false
        end
      end

      context "when potential friend is not already a friend" do
        it "is true" do
          user.can_add_as_friend?(friend).should be_true
        end
      end

      context "when potential friend is the user" do
        it "is false" do
          user.can_add_as_friend?(user).should be_false
        end
      end
    end
  end
end

# -*- coding: utf-8 -*-
require 'spec_helper'

describe User do

  context "validation" do
    it 'requires password' do
      expect do
        u = create_user(:password => nil)
        u.errors.on(:password).should_not be_nil
      end.to_not change(User, :count)
    end

    it 'requires password confirmation' do
      expect do
        u = create_user(:password_confirmation => nil)
        u.errors.on(:password_confirmation).should_not be_nil
      end.to_not change(User, :count)
    end

    it 'requires email' do
      expect do
        u = create_user(:email => nil)
        u.errors.on(:email).should_not be_nil
      end.to_not change(User, :count)
    end

    it 'requires name' do
      expect do
        u = create_user(:name => nil)
        u.errors[:name].should_not be_empty
      end.to_not change(User, :count)
    end
  end

  context "friends" do
    it 'should have no friends to start with' do
      User.new.friends.should be_empty
    end

    it 'should have one friend after befriending someone' do
      user = Factory(:user)
      user.friends << Factory(:random_user)
      user.friends.should have(1).friend
      user.friendships(true).should have(1).friendship
    end
  end

  protected

  def create_user(options = {})
    record = User.new({ :login => 'quire', :email => 'quire@example.com', :password => 'quire69', :password_confirmation => 'quire69' }.merge(options))
    record.save
    record
  end
end

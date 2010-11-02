# -*- coding: utf-8 -*-
require 'spec_helper'

describe User do
  fixtures :users

  context "validation" do
    it 'requires login' do
      expect do
        u = create_user(:login => nil)
        u.errors.on(:login).should_not be_nil
      end.to_not change(User, :count)
    end

    describe 'allows legitimate logins:' do
      ['123', '1234567890_234567890_234567890_234567890',
       'hello.-_there@funnychar.com'].each do |login_str|
        it "'#{login_str}'" do
          expect do
            u = create_user(:login => login_str)
            u.errors.on(:login).should     be_nil
          end.to change(User, :count).by(1)
        end
      end
    end

    describe 'disallows illegitimate logins:' do
      ['12', '1234567890_234567890_234567890_234567890_', "tab\t", "newline\n",
       "Iñtërnâtiônàlizætiøn hasn't happened to ruby 1.8 yet",
       'semicolon;', 'quote"', 'tick\'', 'backtick`', 'percent%', 'plus+', 'space '].each do |login_str|
        it "'#{login_str}'" do
          expect do
            u = create_user(:login => login_str)
            u.errors.on(:login).should_not be_nil
          end.to_not change(User, :count)
        end
      end
    end

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

    describe 'allows legitimate emails:' do
      ['foo@bar.com', 'foo@newskool-tld.museum', 'foo@twoletter-tld.de', 'foo@nonexistant-tld.qq',
       'r@a.wk', '1234567890-234567890-234567890-234567890-234567890-234567890-234567890-234567890-234567890@gmail.com',
       'hello.-_there@funnychar.com', 'uucp%addr@gmail.com', 'hello+routing-str@gmail.com',
       'domain@can.haz.many.sub.doma.in', 'student.name@university.edu'
      ].each do |email_str|
        it "'#{email_str}'" do
          expect do
            u = create_user(:email => email_str)
            u.errors.on(:email).should     be_nil
          end.to change(User, :count).by(1)
        end
      end
    end

    describe 'disallows illegitimate emails' do
      ['!!@nobadchars.com', 'foo@no-rep-dots..com', 'foo@badtld.xxx', 'foo@toolongtld.abcdefg',
       'Iñtërnâtiônàlizætiøn@hasnt.happened.to.email', 'need.domain.and.tld@de', "tab\t", "newline\n",
       'r@.wk', '1234567890-234567890-234567890-234567890-234567890-234567890-234567890-234567890-234567890@gmail2.com',
       # these are technically allowed but not seen in practice:
       'uucp!addr@gmail.com', 'semicolon;@gmail.com', 'quote"@gmail.com', 'tick\'@gmail.com', 'backtick`@gmail.com', 'space @gmail.com', 'bracket<@gmail.com', 'bracket>@gmail.com'
      ].each do |email_str|
        it "'#{email_str}'" do
          expect do
            u = create_user(:email => email_str)
            u.errors.on(:email).should_not be_nil
          end.to_not change(User, :count)
        end
      end
    end

    describe 'allows legitimate names:' do
      ['Andre The Giant (7\'4", 520 lb.) -- has a posse',
       '', '1234567890_234567890_234567890_234567890_234567890_234567890_234567890_234567890_234567890_234567890',
      ].each do |name_str|
        it "'#{name_str}'" do
          expect do
            u = create_user(:name => name_str)
            u.errors.on(:name).should     be_nil
          end.to change(User, :count).by(1)
        end
      end
    end

    describe "disallows illegitimate names" do
      ["tab\t", "newline\n",
       '1234567890_234567890_234567890_234567890_234567890_234567890_234567890_234567890_234567890_234567890_',
       ].each do |name_str|
        it "'#{name_str}'" do
          expect do
            u = create_user(:name => name_str)
            u.errors.on(:name).should_not be_nil
          end.to_not change(User, :count)
        end
      end
    end
  end

  # Domain

  it 'should have no friends to start with' do
    User.new.friends.should be_empty
  end

  it 'should have one friend after befriending someone' do
    user = Factory(:user)
    user.friends << Factory(:random_user)
    user.friends.should have(1).friend
    user.friendships(true).should have(1).friendship
  end

protected
  def create_user(options = {})
    record = User.new({ :login => 'quire', :email => 'quire@example.com', :password => 'quire69', :password_confirmation => 'quire69' }.merge(options))
    record.save
    record
  end
end

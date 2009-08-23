require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  has_many :locations
  has_many :friendships
  has_many :friends, :class_name => 'User', :through => :friendships
  has_many :hosted_nights, :class_name => 'Night', :foreign_key => :host_id

  has_many :invitations, :class_name => 'Invitee', :foreign_key => :invited_user_id do
    def accepted() self.are_attending end
    def pending() self.awaiting_reply end
    def rejected() self.not_attending end
  end

  attr_accessible :login, :email, :name, :password, :password_confirmation

  def to_s
    name
  end

  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_by_login(login.downcase) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    self[:login] = value.try(:downcase)
  end

  def email=(value)
    self[:email] = value.try(:downcase)
  end

end

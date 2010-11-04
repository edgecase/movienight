class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :token_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :name

  has_many :locations, :conditions => {:disabled => false}
  has_many :friendships
  has_many :friends, :class_name => 'User', :through => :friendships
  has_many :hosted_nights, :class_name => 'Night', :foreign_key => :host_id

  has_many :invitations, :foreign_key => :invitee_id do
    def accepted() self.are_attending end
    def pending() self.awaiting_reply end
    def rejected() self.not_attending end
  end

  validates :name, :presence => true, :unless => :invitee?

  def self.find_user_or_create_invitee(email)
    user = find(:first, :conditions => ["LOWER(email)=?", email.downcase.strip])
    unless user
      user = User.new(:email => email)
      user.invitee = true
      user.save
    end
    user
  end

  def to_s
    name
  end

  protected

  def password_required?
    (!persisted? && !invitee?) || password.present? || password_confirmation.present?
  end

end

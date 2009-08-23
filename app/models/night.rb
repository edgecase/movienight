class Night < ActiveRecord::Base
  extend Authentication::ModelClassMethods

  belongs_to :host, :class_name => "User"
  belongs_to :location

  has_many :invitees

  validates_presence_of :curtain_date, :curtain_time
  validates_presence_of :host, :location

  attr_protected :invitee_salt

  before_create :generate_invitee_salt

  def send_invitations(emails)
    return unless emails

    emails.split(/[\s;,]+/).each do |email|
      invite(email)
    end
  end

  def find_invitee(access_hash)
    invitees.find_by_access_hash(access_hash)
  end

  private

  def invite(email)
    user = User.find_by_email(email)
    if user
      Notifier.deliver_registered_member_invitation user, self
    else
      invitee = invitees.create! :email => email
      Notifier.deliver_nonmember_invitation invitee, self
    end
  end

  def generate_invitee_salt
    self.invitee_salt = Night.make_token
  end
end

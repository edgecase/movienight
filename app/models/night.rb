class Night < ActiveRecord::Base
  extend Authentication::ModelClassMethods

  belongs_to :host, :class_name => "User"
  belongs_to :location

  has_many :invitees

  validates_presence_of :curtain_date, :curtain_time
  validates_presence_of :host, :location

  before_create :generate_invitee_salt

  def invitiation_emails=(emails)
    emails.split(/[\s;,]+/).each do |email|
      invite(email)
    end
  end

  private

  def invite(email)
    user = User.find_by_email(email)
    if user
      Notifier.send_registered_member_invitation user
    else
      invitee = invitees.create! :email => email
      Notifier.send_nonmember_invitation invitee
    end
  end

  def generate_invitee_salt
    self.invitee_salt = Night.make_token
  end
end

class Night < ActiveRecord::Base
  extend TokenGeneration

  belongs_to :host, :class_name => "User"
  belongs_to :location
  has_many   :invitations

  belongs_to :movie
  has_many   :voteable_movies

  validates_presence_of :curtain_date, :curtain_time, :host, :location

  attr_protected :invitation_salt

  before_create :generate_invitation_salt

  delegate :name,       :to => :location, :prefix => true
  delegate :human_name, :to => :location, :prefix => true
  delegate :name,       :to => :host,     :prefix => true
  delegate :title,      :to => :movie,    :prefix => true, :allow_nil => true

  scope :sorted, order("nights.curtain_date ASC")

  def human_curtain_date
    curtain_date.strftime("%B ") +
    curtain_date.day.ordinalize
  end

  def human_curtain_time
    curtain_time.to_s(:time).downcase.sub(/^0/, '')
  end

  def send_invitations(emails)
    return unless emails

    emails.split(/[\s;,]+/).each do |email|
      invite(email.strip)
    end
  end

  def find_invitation(access_hash)
    invitations.find_by_access_hash(access_hash)
  end

  private

  def invite(email)
    user = User.find_user_or_create_invitee(email)
    invitation = invitations.new :email => email, :invitee => user
    if invitation.save
      Notifier.nonmember_invitation(invitation, self).deliver
    end
  end

  def generate_invitation_salt
    self.invitation_salt = Night.make_token
  end
end

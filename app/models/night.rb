class Night < ActiveRecord::Base
  extend Authentication::ModelClassMethods

  belongs_to :host, :class_name => "User"
  belongs_to :location

  has_many :invitees

  validates_presence_of :curtain_date, :curtain_time
  validates_presence_of :host, :location

  attr_protected :invitee_salt

  before_create :generate_invitee_salt

  delegate :name, :to => :location, :prefix => true
  delegate :human_name, :to => :location, :prefix => true
  delegate :name, :to => :host,     :prefix => true

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

  def find_invitee(access_hash)
    invitees.find_by_access_hash(access_hash)
  end

  private

  def invite(email)
    user = User.find(:first, :conditions => ["LOWER(email)=?", email.downcase.strip])
    invitee = invitees.new :email => email, :invited_user => user
    if invitee.save
      Notifier.deliver_nonmember_invitation invitee, self
    end
  end

  def generate_invitee_salt
    self.invitee_salt = Night.make_token
  end
end

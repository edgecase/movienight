class Invitation < ActiveRecord::Base
  extend TokenGeneration

  belongs_to :night
  belongs_to :invitee, :class_name => "User"

  validates_presence_of   :night, :invitee
  validates_uniqueness_of :night_id, :scope => :invitee_id

  before_create :generate_access_hash
  after_create  :send_notification

  attr_accessible :attending

  delegate :email, :to => :invitee
  delegate :location_name, :location_human_name, :curtain_date,
           :human_curtain_date, :human_curtain_time, :host_name,
           :movie_title, :to => :night

  scope :awaiting_reply, where(:attending => nil)
  scope :are_attending,  where(:attending => true)
  scope :not_attending,  where(:attending => false)
  scope :sorted,         joins(:night).order("nights.curtain_date")

  def to_param
    access_hash if persisted?
  end

  private

  def generate_access_hash
    self.access_hash = self.class.make_hash(email, night.invitation_salt)
  end

  def send_notification
    if invitee.invitee?
      Notifier.registered_member_invitation(self, night).deliver
    else
      Notifier.nonmember_invitation(self, night).deliver
    end
  end

end

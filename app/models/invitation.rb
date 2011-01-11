class Invitation < ActiveRecord::Base

  belongs_to :night
  belongs_to :invitee, :class_name => "User"

  validates_presence_of   :night, :invitee
  validates_uniqueness_of :night_id, :scope => :invitee_id

  attr_accessible :attending

  delegate :email, :to => :invitee
  delegate :location_name, :location_human_name, :curtain_date,
           :human_curtain_date, :human_curtain_time, :host_name,
           :movie_title, :to => :night

  scope :awaiting_reply, where(:attending => nil)
  scope :are_attending,  where(:attending => true)
  scope :not_attending,  where(:attending => false)
  scope :sorted,         joins(:night).order("nights.curtain_date")

  def deliver
    mail = Notifier.night_invitation(self)
    mail.deliver
  end
end

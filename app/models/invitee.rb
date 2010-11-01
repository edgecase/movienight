class Invitee < ActiveRecord::Base

  belongs_to :night
  belongs_to :invited_user, :class_name => "User"

  has_many :votes

  validates_presence_of :night, :email
  validates_uniqueness_of :night_id, :scope => [:email]

  before_create :generate_access_hash

  attr_protected :access_hash

  delegate :location_name, :location_human_name, :curtain_date,
           :human_curtain_date, :human_curtain_time, :host_name,
           :to => :night

  scope :are_attending,  where(:attending => true)
  scope :awaiting_reply, where(:attending => nil)
  scope :not_attending,  where(:attending => false)
  scope :sorted,         joins(:night).order("nights.curtain_date")

  private

  def generate_access_hash
    self.access_hash = 'abc123'#Invitee.password_digest(email, night.invitee_salt)
  end
end

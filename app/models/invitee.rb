class Invitee < ActiveRecord::Base

  belongs_to :night
  belongs_to :invited_user, :class_name => "User"

  has_many :votes

  validates_presence_of :night, :email
  validates_uniqueness_of :night_id, :scope => [:email]

  before_create :generate_access_hash

  attr_protected :access_hash

  named_scope :are_attending, { :conditions => { :attending => true } }
  named_scope :awaiting_reply, { :conditions => { :attending => nil } }
  named_scope :not_attending, { :conditions => { :attending => false } }

  named_scope :sorted, { :order => "nights.curtain_date", :joins => :night }

  delegate :location_name, :location_human_name, :curtain_date,
       :human_curtain_date, :human_curtain_time, :host_name, :to => :night

  private

  def generate_access_hash
    self.access_hash = 'abc123'#Invitee.password_digest(email, night.invitee_salt)
  end
end

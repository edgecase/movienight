class Invitee < ActiveRecord::Base
  extend Authentication::ByPassword::ModelClassMethods
  extend Authentication::ModelClassMethods

  belongs_to :night
  belongs_to :invited_user, :class_name => "User"

  validates_presence_of :night, :email
  validates_uniqueness_of :night_id, :scope => [:email]

  before_create :generate_access_hash

  attr_protected :access_hash

  named_scope :are_attending, { :conditions => {:attending => true} }

  private

  def generate_access_hash
    self.access_hash = Invitee.password_digest(email, night.invitee_salt)
  end
end

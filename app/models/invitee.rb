class Invitee < ActiveRecord::Base
  extend Authentication::ByPassword::ModelClassMethods
  include Authentication

  belongs_to :night

  validates_presence_of :night, :email

  before_create :generate_access_hash

  private

  def generate_access_hash
    self.access_hash = Invitee.password_digest(email, night.invitee_salt)
  end
end

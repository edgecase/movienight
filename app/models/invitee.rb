class Invitee < ActiveRecord::Base
  include Authentication

  belongs_to :night

  validates_presence_of :night, :email, :access_hash

  validates_uniqueness_of :email
  validates_format_of     :email, :with => Authentication.email_regex, :message => Authentication.bad_email_message

  before_create :generate_access_hash

  def generate_access_hash
    
  end
end

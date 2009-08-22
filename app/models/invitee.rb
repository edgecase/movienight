class Invitee < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword

  belongs_to :night

  validates_presence_of :night, :email, :hash

  validates_uniqueness_of :email
  validates_format_of     :email, :with => Authentication.email_regex, :message => Authentication.bad_email_message

  before_validation :generate_hash

  
end

class Night < ActiveRecord::Base
  extend Authentication::ModelClassMethods

  belongs_to :host, :class_name => "User"
  belongs_to :location

  validates_presence_of :curtain_date, :curtain_time
  validates_presence_of :host, :location

  before_create :generate_invitee_salt

  private

  def generate_invitee_salt
    self.invitee_salt = Night.make_token
  end
end

class Night < ActiveRecord::Base
  extend Authentication::ModelClassMethods

  belongs_to :host, :class_name => "User"
  belongs_to :location

  validates_presence_of :doors_open_date
  validates_presence_of :doors_open_time
  validates_presence_of :host

  before_create :generate_invitee_salt

  private

  def generate_invitee_salt
    self.invitee_salt = Night.make_token
  end
end

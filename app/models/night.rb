class Night < ActiveRecord::Base
  extend TokenGeneration

  belongs_to :host, :class_name => "User"
  belongs_to :location
  has_many   :invitations

  belongs_to :movie
  has_many   :voteable_movies
  has_many   :votes,  :through => :voteable_movies

  accepts_nested_attributes_for :voteable_movies

  validates_presence_of :curtain_date, :curtain_time, :host, :location

  attr_protected :invitation_salt

  before_create :generate_invitation_salt

  delegate :name,       :to => :location, :prefix => true
  delegate :human_name, :to => :location, :prefix => true
  delegate :name,       :to => :host,     :prefix => true
  delegate :title,      :to => :movie,    :prefix => true, :allow_nil => true

  scope :sorted, order("nights.curtain_date ASC")

  def voters
    voteable_movies.collect {|movie| movie.voters }.flatten
  end

  def hosted_by?(user)
    host == user
  end

  def invitees_include?(user)
    invitations.find_by_invitee_id(user)
  end

  def voted_on_by?(user)
    return false unless user.try :id
    votes.collect {|v| v.voter_id }.include?(user.id)
  end

  def human_curtain_date
    curtain_date.strftime("%B ") +
    curtain_date.day.ordinalize
  end

  def human_curtain_time
    curtain_time.to_s(:time).downcase.sub(/^0/, '')
  end

  def send_invitations(emails)
    parsed(emails).each do |email|
      user   = User.find_user_or_create_invited_user(email)
      invite = invitations.build

      invite.invitee = user
      if invite.save
        invite.deliver
      end
    end
  end

  def find_invitation(access_hash)
    invitations.find_by_access_hash(access_hash)
  end

  private

  def parsed(emails)
    return [] unless emails
    emails.split(/[\s;,]+/).map(&:strip)
  end

  def generate_invitation_salt
    self.invitation_salt = Night.make_token
  end
end

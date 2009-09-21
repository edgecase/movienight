class Location < ActiveRecord::Base
  belongs_to :user
  has_many :nights

  validates_presence_of :street, :name

  named_scope :enabled, :conditions => ["disabled = ?", false]

  def to_s
    city_state = [city, state].compact.join(" ")
    [street, city_state].compact.join(", ")
  end

  def human_name
    "#{user.name}'s #{name}"
  end

  def enabled?
    !self.disabled
  end
end

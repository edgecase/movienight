class Friendship < ActiveRecord::Base

  belongs_to :user
  belongs_to :friend, :class_name => "User"

  validates_uniqueness_of :friend_id, :scope => :user_id
  validate :user_is_not_friending_self

  private
  def user_is_not_friending_self
    if user.id == friend.id
      errors.add(:base, "Cannot add oneself as a friend")
    end
  end

end

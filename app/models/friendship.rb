class Friendship < ActiveRecord::Base

  belongs_to :user
  belongs_to :friend, :class_name => "User", :foreign_key => :friend_id

  validates_uniqueness_of :friend_id, :scope => :user_id
  validate :ensure_user_cannot_have_itself_as_a_friend

  def ensure_user_cannot_have_itself_as_a_friend
    if user.id == friend.id
      errors.add("Cannot add oneself as a friend")
    end
  end

  def invite!
    self[:invited_count] += 1
    Friendship.increment_counter(:invited_count, self.id)
  end

end

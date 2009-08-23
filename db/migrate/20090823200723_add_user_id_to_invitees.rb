class AddUserIdToInvitees < ActiveRecord::Migration
  def self.up
    add_column :invitees, :invited_user_id, :integer
  end

  def self.down
    remove_column :invitees, :invited_user_id
  end
end

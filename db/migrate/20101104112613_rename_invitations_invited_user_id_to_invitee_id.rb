class RenameInvitationsInvitedUserIdToInviteeId < ActiveRecord::Migration
  def self.up
    rename_column :invitees, :invited_user_id, :invitee_id
  end

  def self.down
    rename_column :invitees, :invitee_id, :invited_user_id
  end
end

class RenameNightsInviteeSaltToInvitationSalt < ActiveRecord::Migration
  def self.up
    rename_column :nights, :invitee_salt, :invitation_salt
  end

  def self.down
    rename_column :nights, :invitation_salt, :invitee_salt
  end
end

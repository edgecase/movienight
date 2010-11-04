class RenameInviteesToInvitations < ActiveRecord::Migration
  def self.up
    rename_table :invitees, :invitations
  end

  def self.down
    rename_table :invitations, :invitees
  end
end

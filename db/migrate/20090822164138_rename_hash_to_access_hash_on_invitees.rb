class RenameHashToAccessHashOnInvitees < ActiveRecord::Migration
  def self.up
    rename_column :invitees, :hash, :access_hash
  end

  def self.down
    rename_column :invitees, :access_hash, :hash
  end
end

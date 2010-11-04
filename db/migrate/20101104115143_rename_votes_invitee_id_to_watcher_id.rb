class RenameVotesInviteeIdToWatcherId < ActiveRecord::Migration
  def self.up
    rename_column :votes, :invitee_id, :watcher_id
  end

  def self.down
    rename_column :votes, :watcher_id, :invitee_id
  end
end

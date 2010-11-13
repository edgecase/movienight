class ChangeUsersInviteeDefault < ActiveRecord::Migration
  def self.up
    change_column :users, :invitee, :boolean, :default => false
  end

  def self.down
    change_column :users, :invitee, :boolean
  end
end

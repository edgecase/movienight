class AddInviteeToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :invitee, :boolean
  end

  def self.down
    remove_column :users, :invitee
  end
end

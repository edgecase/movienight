class AddInviteeSaltToNights < ActiveRecord::Migration
  def self.up
    add_column :nights, :invitee_salt, :string
  end

  def self.down
    remove_column :nights, :invitee_salt
  end
end

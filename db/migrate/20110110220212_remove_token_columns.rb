class RemoveTokenColumns < ActiveRecord::Migration
  def self.up
    remove_column :nights, :invitation_salt
    remove_column :invitations, :access_hash
  end

  def self.down
    add_column :invitations, :access_hash, :string
    add_column :nights, :invitation_salt,  :string
  end
end

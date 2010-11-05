class RemoveEmailFromInvitations < ActiveRecord::Migration
  def self.up
    remove_column :invitations, :email
  end

  def self.down
    add_column :invitations, :email, :string, :nil => false
  end
end

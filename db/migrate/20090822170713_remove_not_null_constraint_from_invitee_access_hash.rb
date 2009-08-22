class RemoveNotNullConstraintFromInviteeAccessHash < ActiveRecord::Migration
  def self.up
    change_column :invitees, :access_hash, :string, :null => true
  end

  def self.down
    change_column :invitees, :access_hash, :string, :null => false
  end
end

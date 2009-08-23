class AddAttendingBooleanToInvitees < ActiveRecord::Migration
  def self.up
    add_column :invitees, :attending, :boolean
  end

  def self.down
    remove_column :invitees, :attending
  end
end

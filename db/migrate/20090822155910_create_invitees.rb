class CreateInvitees < ActiveRecord::Migration
  def self.up
    create_table :invitees do |t|
      t.integer :night_id, :null => false
      t.string  :email,    :null => false
      t.string  :hash,     :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :invitees
  end
end

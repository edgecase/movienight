class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    drop_table :users
    create_table(:users) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable
      t.token_authenticatable


      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
  end

  def self.down
    drop_table :users
    create_table :users do |t|
      t.timestamps
    end
  end
end

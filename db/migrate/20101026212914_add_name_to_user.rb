class AddNameToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :name, :string, :length => 256
  end

  def self.down
    remove_column :users, :name
  end
end

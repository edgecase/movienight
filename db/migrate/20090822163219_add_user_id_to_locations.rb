class AddUserIdToLocations < ActiveRecord::Migration
  def self.up
    add_column :locations, :user_id, :integer
  end

  def self.down
    remove_column :locations, :user_id
  end
end

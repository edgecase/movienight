class AddDisabledToLocations < ActiveRecord::Migration
  def self.up
    add_column :locations, :disabled, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :locations, :disabled
  end
end

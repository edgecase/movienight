class AddLocationIdToNights < ActiveRecord::Migration
  def self.up
    add_column :nights, :location_id, :integer
  end

  def self.down
    remove_column :nights, :location_id
  end
end

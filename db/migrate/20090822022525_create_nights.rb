class CreateNights < ActiveRecord::Migration
  def self.up
    create_table :nights do |t|
      t.datetime :curtain_time_at
      t.datetime :doors_open_at
      t.integer :host_id

      t.timestamps
    end
  end

  def self.down
    drop_table :nights
  end
end

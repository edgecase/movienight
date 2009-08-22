class ChangeNightTimeFormats < ActiveRecord::Migration
  def self.up
    remove_column :nights, :doors_open_at
    remove_column :nights, :curtain_time_at

    add_column :nights, :doors_open_time, :time
    add_column :nights, :doors_open_date, :date
    add_column :nights, :curtain_time, :time
    add_column :nights, :curtain_date, :date
  end

  def self.down
    remove_column :nights, :curtain_date
    remove_column :nights, :curtain_time
    remove_column :nights, :doors_open_date
    remove_column :nights, :doors_open_time

    add_column :nights, :curtain_time_at, :datetime
    add_column :nights, :doors_open_at, :datetime
  end
end

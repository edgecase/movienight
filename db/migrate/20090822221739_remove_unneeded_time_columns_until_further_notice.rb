class RemoveUnneededTimeColumnsUntilFurtherNotice < ActiveRecord::Migration
  def self.up
    remove_column :nights, :doors_open_date
    remove_column :nights, :doors_open_time
  end

  def self.down
    add_column :nights, :doors_open_time, :time
    add_column :nights, :doors_open_date, :date
  end
end

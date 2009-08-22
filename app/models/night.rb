class Night < ActiveRecord::Base
  belongs_to :host, :class_name => "User"
  belongs_to :location

  validates_presence_of :doors_open_date
  validates_presence_of :doors_open_time
  validates_presence_of :host, :location
end

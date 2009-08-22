class Night < ActiveRecord::Base
  belongs_to :host, :class_name => "User"

  validates_presence_of :doors_open_date
  validates_presence_of :doors_open_time
  validates_presence_of :host
end

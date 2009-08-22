class Night < ActiveRecord::Base
  belongs_to :host, :class_name => "User"

  validates_presence_of :doors_open_date
  validates_presence_of :doors_open_time
  validates_presence_of :host

  def curtain_time_at
    "#{curtain_date.try(:to_s, :date)}, #{curtain_time.try(:to_s, :time)}"
  end

  def doors_open_at
    "#{doors_open_date.try(:to_s, :date)}, #{doors_open_time.try(:to_s, :time)}"
  end
end

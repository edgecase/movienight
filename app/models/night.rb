class Night < ActiveRecord::Base
  def curtain_time_at
    "#{curtain_date.try(:to_s, :date)}, #{curtain_time.try(:to_s, :time)}"
  end

  def doors_open_at
    "#{doors_open_date.try(:to_s, :date)}, #{doors_open_time.try(:to_s, :time)}"
  end
end

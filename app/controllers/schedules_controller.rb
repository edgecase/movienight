class SchedulesController < ApplicationController
  def show
    @nights = Night.all
  end
end

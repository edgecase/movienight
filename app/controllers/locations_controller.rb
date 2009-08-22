class LocationsController < ApplicationController
  layout false
  
  def create
    @location = current_user.locations.new(params[:location])
    if @location.save
      @locations = current_user.locations
      render :action => :index
    else
      render :text => @location.errors.full_messages.to_sentence, :status => 400
    end
  end

  def index
    @locations = current_user.locations
  end
end

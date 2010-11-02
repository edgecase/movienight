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

  def edit
    respond_to do |format|
      location = Location.find(params[:id])
      format.js do
        render :partial => 'locations/edit', :locals => {:location => location}
      end
    end
  end

  def destroy
    @location = current_user.locations.find(params[:id])
    if @location.update_attributes(:disabled => true)
      @locations = current_user.locations
      render :action => :index
    else
      render :text => @location.errors.full_messages.to_sentence, :status => 400
    end
  end

  def update
    @location = current_user.locations.find(params[:id])
    if @location.update_attributes(params[:location])
      @locations = current_user.locations
      render :action => :index
    else
      render :text => @location.errors.full_messages.to_sentence, :status => 400
    end
  end

end

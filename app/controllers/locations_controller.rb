class LocationsController < ApplicationController
  layout false

  assume(:locations) { current_user.locations }
  assume(:location)  { locations.find(params[:id]) }

  def create
    self.location = locations.new(params[:location])
    if location.save
      render :action => :index
    else
      render :text => location.errors.full_messages.to_sentence, :status => 400
    end
  end

  def index
  end

  def edit
    respond_to do |format|
      format.js do
        render :partial => 'locations/edit'
      end
    end
  end

  def destroy
    if location.update_attributes(:disabled => true)
      render :action => :index
    else
      render :text => location.errors.full_messages.to_sentence, :status => 400
    end
  end

  def update
    if location.update_attributes(params[:location])
      render :action => :index
    else
      render :text => location.errors.full_messages.to_sentence, :status => 400
    end
  end

end

class NightsController < ApplicationController
  before_filter      :current_user_is_host?, :only => [:edit, :update, :destroy]

  assume(:night)                { Night.find(params[:id]) }
  assume(:hosted_nights)        { current_user.hosted_nights.sorted        }

  assume(:invitation)           { current_user.invitations.pending.find_by_night_id(night) }
  assume(:accepted_invitations) { current_user.invitations.accepted.sorted }
  assume(:pending_invitations)  { current_user.invitations.pending.sorted  }

  def index
  end

  def show
  end

  def new
    self.night = current_user.hosted_nights.build
  end

  def edit
  end

  def create
    self.night = current_user.hosted_nights.build(params[:night])

    if night.save
      flash[:success] = 'Night was successfully created.'
      redirect_to(night)
    else
      render :action => "new"
    end
  end

  def update
    if night.update_attributes(params[:night])
      respond_to do |format|
        format.json { render :json => night.to_json(:include => :movie) }
        format.html do
          flash[:notice] = 'Night was successfully updated.'
          redirect_to(night)
        end
      end
    else
      respond_to do |format|
        format.json { render :json => { :errors => night.errors.full_messages }, :status => :forbidden }
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    night = current_user.hosted_nights.find(params[:id])
    night.destroy

    redirect_to(nights_url)
  end
end

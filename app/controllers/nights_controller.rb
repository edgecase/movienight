class NightsController < ApplicationController
  skip_before_filter :authenticate_user!,    :only => :show
  before_filter      :logged_in_or_invited?, :only => :show

  assume(:night) do
    if current_user
      current_user.hosted_nights.find(params[:id])
    else
      Night.find(params[:id])
    end
  end
  assume(:invitation) do
    if current_user
      current_user.invitations.pending.find_by_night_id(night)
    end
  end

  assume(:hosted_nights)        { current_user.hosted_nights.sorted        }
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
      flash[:notice] = 'Night was successfully updated.'
      redirect_to(night)
    else
      render :action => "edit"
    end
  end

  def destroy
    night = current_user.hosted_nights.find(params[:id])
    night.destroy

    redirect_to(nights_url)
  end

  private

  def logged_in_or_invited?
    unless user_signed_in?
      unless session[:accessible_night] == night.id
        redirect_to new_user_session_path
      end
    end
  end

end

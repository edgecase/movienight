class NightsController < ApplicationController
  skip_before_filter :authenticate_user!, :only => :show

  def index
    @hosted_nights        = current_user.hosted_nights.sorted
    @accepted_invitations = current_user.invitations.accepted.sorted
    @pending_invitations  = current_user.invitations.pending.sorted
  end

  def show
    @night = Night.find(params[:id])
    redirect_to new_user_session_path and return unless logged_in_or_invited?
    if user_signed_in?
      @invitee = current_user.invitations.pending.find_by_night_id(@night)
    end
  end

  def new
    @night = current_user.hosted_nights.build
  end

  def edit
    @night = current_user.hosted_nights.find(params[:id])
  end

  def create
    @night = current_user.hosted_nights.build(params[:night])

    if @night.save
      flash[:success] = 'Night was successfully created.'
      redirect_to(@night)
    else
      render :action => "new"
    end
  end

  def update
    @night = current_user.hosted_nights.find(params[:id])

    if @night.update_attributes(params[:night])
      flash[:notice] = 'Night was successfully updated.'
      redirect_to(@night)
    else
      render :action => "edit"
    end
  end

  def destroy
    @night = current_user.hosted_nights.find(params[:id])
    @night.destroy

    redirect_to(nights_url)
  end

  private
  def logged_in_or_invited?
    if !user_signed_in?
      if session[:accessible_night] != @night.id
        return false
      end
    end
    true
  end
end

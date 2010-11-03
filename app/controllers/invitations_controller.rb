class InvitationsController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:edit, :update]
  before_filter      :find_night

  def new
  end

  def create
    @night.send_invitations params[:invitation_emails]
    flash[:success] = "Invitations sent."
    redirect_to @night
  end

  def edit
    @invitee = @night.find_invitee params[:id]
    session[:accessible_night] = @night.id
    render 'nights/show'
  end

  def update
    @invitee = @night.find_invitee params[:id]
    @invitee.update_attributes(:attending => params[:attending])
    redirect_to night_path(@night)
  end

  protected

  def find_night
    @night = if current_user.present?
      current_user.hosted_nights.find(params[:night_id])
    else
      Night.find(params[:night_id])
    end
  end

end

class InvitationsController < ApplicationController
  skip_before_filter :authenticate_user!,    :only => [:edit, :update]
  before_filter      :current_user_is_host?, :only => :create

  assume(:night)      { Night.find(params[:night_id]) }
  assume(:invitation) { night.find_invitation(params[:id]) }
  assume(:invitee)    { invitation.try(:invitee) }

  def new
  end

  def create
    night.send_invitations params[:invitation_emails]
    flash[:success] = "Invitations sent!"
    redirect_to night
  end

  def edit
    session[:accessible_night] = night.id
    render 'nights/show'
  end

  def update
    invitation.update_attributes(:attending => params[:attending])
    redirect_to night_path(night)
  end

end

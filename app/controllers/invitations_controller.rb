class InvitationsController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:edit, :update]

  #assume :night, :of => :current_user, :as => :hosted_night, :fallback => true

  assume(:night) do
    if current_user.present?
      current_user.hosted_nights.find(params[:night_id])
    else
      Night.find(params[:night_id])
    end
  end
  assume(:invitation) { night.find_invitation(params[:id]) }
  assume(:invitee)    { invitation.try(:invitee) }

  def new
  end

  def create
    night.send_invitations params[:invitation_emails]
    flash[:success] = "Invitations sent."
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

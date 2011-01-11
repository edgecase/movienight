class InvitationsController < ApplicationController
  before_filter      :current_user_is_host?, :only => :create

  assume(:night)      { Night.find(params[:night_id]) }
  assume(:invitation) { night.invitations.find(params[:id]) }
  assume(:invitee)    { invitation.try(:invitee) }

  def create
    night.send_invitations params[:invitation_emails]
    flash[:success] = "Invitations sent!"
    redirect_to night
  end

  def update
    invitation.update_attributes(:attending => params[:attending])
    redirect_to night_path(night)
  end
end

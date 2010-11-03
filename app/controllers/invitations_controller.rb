class InvitationsController < ApplicationController

  before_filter :find_night

  def new
  end

  def create
    @night.send_invitations params[:invitation_emails]
    flash[:success] = "Invitations sent."
    redirect_to @night
  end
  
  protected
  
  def find_night
    @night = current_user.hosted_nights.find(params[:night_id])
  end
  
end
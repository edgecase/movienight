class SchedulesController < ApplicationController
  def show
    @accepted_invitations = current_user.invitations.accepted
    @pending_invitations = current_user.invitations.pending
  end
end

class SchedulesController < ApplicationController
  def show
    @hosted_nights = current_user.hosted_nights.sorted
    @accepted_invitations = current_user.invitations.accepted.sorted
    @pending_invitations = current_user.invitations.pending.sorted
  end
end

class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  before_filter :authenticate_user!

  private
  def current_user_is_host?
    unless night.hosted_by? current_user
      flash[:error] = "You must be the host to do that!"
      redirect_to root_path
    end
  end

  def log_in_token_user
    return unless current_user && current_user.invitee?
    return unless current_user.authentication_token == params[:auth_token]
    sign_in(current_user, :bypass => true)
    redirect_to "http://#{request.host}#{request.port != 80 ? ':' + request.port.to_s : nil}#{request.request_uri}"
  end
end

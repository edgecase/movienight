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
end

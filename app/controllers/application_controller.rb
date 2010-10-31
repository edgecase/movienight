class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  before_filter :authenticate_user!
end

require File.dirname(__FILE__) + '/spec_helper'

shared_examples_for "an action that requires login" do
  before do
    @currently_logged_in_user = stub_model(User)
    request.session[:user] = @currently_logged_in_user.id
    controller.stub! :logged_in? => true
    controller.stub! :current_user => @currently_logged_in_user
  end

  it "redirects to '/login' when not logged in" do
    controller.stub! :logged_in? => false
    http_request
    response.should redirect_to(login_path)
  end
end


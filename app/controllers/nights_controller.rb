class NightsController < ApplicationController
  skip_before_filter :login_required, :only => [:nonmember_rsvp, :complete_rsvp, :show]
  before_filter :persist_host_info, :only => [:send_invitations]

  def index
    @nights = Night.all
  end

  def show
    @night = Night.find(params[:id])
    redirect_to login_path and return unless logged_in_or_invited?
  end

  def new
    @night = current_user.hosted_nights.build
  end

  def edit
    @night = current_user.hosted_nights.find(params[:id])
  end

  def create
    @night = current_user.hosted_nights.build(params[:night])

    if @night.save
      flash[:success] = 'Night was successfully created.'
      redirect_to(@night)
    else
      render :action => "new"
    end
  end

  def update
    @night = current_user.hosted_nights.find(params[:id])

    if @night.update_attributes(params[:night])
      flash[:notice] = 'Night was successfully updated.'
      redirect_to(@night)
    else
      render :action => "edit"
    end
  end

  def destroy
    @night = current_user.hosted_nights.find(params[:id])
    @night.destroy

    redirect_to(nights_url)
  end

  def add_invitations
    @night = current_user.hosted_nights.find(params[:id])
  end

  def send_invitations
    @night = current_user.hosted_nights.find(params[:id])
    @night.send_invitations params[:invitation_emails]
    flash[:success] = "Invitations sent."
    redirect_to @night
  end

  def nonmember_rsvp
    @night = Night.find(params[:id])
    @invitee = @night.find_invitee params[:access_hash]
    session[:accessible_night] = @night.id
    render :action => :show
  end

  def complete_rsvp
    @night = Night.find(params[:id])
    @invitee = @night.find_invitee params[:access_hash]
    @invitee.update_attributes(:attending => params[:attending])
    redirect_to night_path(@night)
  end

  def title_search
    @movies = TheMovieDatabase.search_titles(params[:movie_title])
    render :layout => false 
  end

  private
  def logged_in_or_invited?
    if !logged_in?
      if session[:accessible_night] != @night.id
        return false
      end
    end
    true
  end
end

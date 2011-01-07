class VotesController < ApplicationController
  before_filter :user_must_be_invited
  before_filter :user_must_not_have_voted

  respond_to :json

  assume(:voteable_movie) { VoteableMovie.includes(:night).find(params[:voteable_movie_id]) }
  assume(:night)          { voteable_movie.night }
  assume(:vote)           { Vote.new(:voteable_movie => voteable_movie, :voter => current_user) }

  def create
    if vote.save
      respond_with({:count => voteable_movie.votes.count}, :location => false, :status => :ok)
    else
      respond_with({}, :location => false, :status => :error)
    end
  end

  private
  def user_must_be_invited
    return if current_user == night.host
    unless night.invitations.find_by_invitee_id(current_user)
      render :json => nil, :status => :not_authorized
    end
  end

  def user_must_not_have_voted
    if night.voted_on_by?(current_user)
      render :json => nil, :status => :forbidden
    end
  end
end

class UsersController < ApplicationController
  helper :all

  def add_friend
    friend     = User.find(params[:friend_id])
    friendship = Friendship.new(:user => current_user, :friend => friend)
    if friendship.save
      respond_to do |format|
        format.json { render :json => friendship.to_json }
      end
    end
  end

  def all_friends
    respond_to do |format|
      format.json { render :json => current_user.friends.to_json(:methods => :gravatar_url) }
    end
  end

  private
  def friends_json
    current_user.friends.map {|f| f.attributes.merge(:gravatar_url => gravatar_url(f)) }.to_json
  end

end

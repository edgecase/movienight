class VoteableMovie < ActiveRecord::Base
  belongs_to :night
  belongs_to :movie

  has_many :votes
  has_many :voters, :class_name => "Invitee", :through => :votes

  delegate :poster_url, :title, :release, :imdb_id, :tmdb_id, :to => :movie
end

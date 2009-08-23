class VoteableMovie < ActiveRecord::Base
  belongs_to :night
  belongs_to :movie

  delegate :poster_url, :title, :release, :imdb_id, :tmdb_id, :to => :movie
end

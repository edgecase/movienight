class VoteableMovie < ActiveRecord::Base
  belongs_to :night
  belongs_to :movie

  has_many :votes
  has_many :voters, :through => :votes

  delegate :poster_url, :title, :release, :imdb_id, :tmdb_id, :to => :movie

  def movie_id
    movie.id
  end
end

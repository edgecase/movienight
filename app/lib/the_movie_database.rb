require 'httparty'

module TheMovieDatabase
  include HTTParty
  format :xml
  base_uri 'api.themoviedb.org/2.0'
  default_params :api_key => '2a9160b01325c41b4596f52a2b460842'

  def self.search_titles(title)
    movie_listings_for(title).collect do |listing|
      movie_from listing
    end
  end

  class << self
    private
    def movie_listings_for(title)
      begin
        listings = get('/Movie.search', :query => {:title => title})
        listings['results']['moviematches']['movie'].select do |listing|
          listing['type'] == 'movie'
        end
      rescue
        []
      end
    end

    def movie_from(listing)
      Movie.new(
        :title      => listing['title'],
        :alt_title  => listing['alternative_title'],
        :popularity => listing['popularity'],
        :tmdb_id    => listing['id'],
        :imdb_id    => listing['imdb'],
        :posters    => listing['poster']
      ).tap do |movie|
        movie.release = DateTime.parse(listing['release']) if listing['release'] 
      end
    end
  end
end

require 'httparty'

module TheMovieDatabase
  include HTTParty
  format :xml
  base_uri 'api.themoviedb.org/2.0'
  default_params :api_key => '2a9160b01325c41b4596f52a2b460842'

  def self.search_titles(title)
    results = self.get('/Movie.search', :query => {:title => title})
    raw_matches = results['results']['moviematches']['movie'] rescue []
    search_results = []
    raw_matches.each do |match|
      if match['type'] == 'movie'
        movie = Movie.new(
          :title       => match['title'],
          :alt_title   => match['alternative_title'],
          :popularity  => match['popularity'],
          :tmdb_id     => match['id'],
          :imdb_id     => match['imdb'],
          :posters     => match['poster']
        )
        movie.release = DateTime.parse(match['release']) if match['release'] 
        search_results << movie
      end
    end
    search_results
  end
end

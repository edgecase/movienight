class MoviesController < ApplicationController

  assume(:movies) { TheMovieDatabase.search_titles(params[:movie_title]) }

  def title_search
    respond_to do |format|
      format.json do
        results = {:count => movies.count}
        results[:movies] = movies.map do |movie|
          movie.attributes.
            merge(:poster_url   => movie.poster_url(:thumb) || '/images/no_poster.jpg').
            merge(:release_date => movie.release.try(:to_s, :long))
        end
        render :json => results
      end
    end
  end

end

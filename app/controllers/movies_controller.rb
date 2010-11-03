class MoviesController < ApplicationController

  assume(:movies) { TheMovieDatabase.search_titles(params[:movie_title]) }

  def title_search
    render :layout => false
  end

end

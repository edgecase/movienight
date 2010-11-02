class MoviesController < ApplicationController

  def title_search
    @movies = TheMovieDatabase.search_titles(params[:movie_title])
    render :layout => false
  end

end

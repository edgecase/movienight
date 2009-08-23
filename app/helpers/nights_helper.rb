module NightsHelper
  def poster_url(movie)
    if movie.posters
      movie.poster_url
    else
      ""
    end
  end
end

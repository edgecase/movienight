class Movie < ActiveRecord::Base
  serialize :posters, Array

  def poster_url(size = :cover)
    self.posters.select do |p|
      p =~ /#{size}.(jpg|gif|png|bmp)\Z/i
    end.first
  end
end

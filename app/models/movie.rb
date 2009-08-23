class Movie < ActiveRecord::Base
  serialize :posters, Array

  def posters
    self[:posters] || []
  end

  def poster_url(size = :cover)
    self.posters.find do |p|
      p =~ /#{size}.(jpg|gif|png|bmp)\Z/i
    end
  end
end

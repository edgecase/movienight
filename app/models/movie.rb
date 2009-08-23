class Movie < ActiveRecord::Base
  serialize :posters, Array

  def poster_url(size = :thumb)
    size = nil if size == :full
    self.posters.select do |p|
      p =~ /#{size.to_s}.(jpg|gif|png|bmp)\Z/i
    end.first
  end
end

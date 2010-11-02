require 'spec_helper'

describe Movie do
  before(:each) do
    @valid_attributes = {
      :title => "value for title",
      :alt_title => "value for alt_title",
      :popularity => 9.99,
      :tmdb_id => "value for tmdb_id",
      :imdb_id => "value for imdb_id",
      :release => Time.now,
      :posters => ["value for posters"]
    }
  end

  it "should create a new instance given valid attributes" do
    Movie.create!(@valid_attributes)
  end
end

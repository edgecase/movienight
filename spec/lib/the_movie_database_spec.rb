require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TheMovieDatabase do
  it "should return potential matches for a title search" do
    matches = TheMovieDatabase.search_titles("Ghostbusters")
    matches.should_not be_nil
    matches.first.title.should =~ /ghostbusters/i
  end
end

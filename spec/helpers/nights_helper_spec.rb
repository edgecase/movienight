require 'spec_helper'

describe NightsHelper do
  describe "show_voteable_movies?" do
    context "when the night has a movie" do
      let(:night) { Night.new(:movie => Movie.new) }
      it "is false" do
        helper.show_voteable_movies?(night).should be_false
      end
    end

    context "when the night does not have a movie" do
      let(:night) { Night.new }
      context "but has voteable_movies" do
        before do
          night.voteable_movies.build
        end
        it "is true" do
          helper.show_voteable_movies?(night).should be_true
        end
      end

      context "and has no voteable_movies" do
        it "is false" do
          helper.show_voteable_movies?(night).should be_false
        end
      end
    end
  end
end

class CreateVoteableMovies < ActiveRecord::Migration
  def self.up
    create_table :voteable_movies do |t|
      t.integer :night_id
      t.integer :movie_id

      t.timestamps
    end
  end

  def self.down
    drop_table :voteable_movies
  end
end

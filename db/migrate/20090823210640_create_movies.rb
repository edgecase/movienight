class CreateMovies < ActiveRecord::Migration
  def self.up
    create_table :movies do |t|
      t.string :title
      t.string :alt_title
      t.float :popularity
      t.string :tmdb_id
      t.string :imdb_id
      t.datetime :release
      t.text :posters

      t.timestamps
    end
  end

  def self.down
    drop_table :movies
  end
end

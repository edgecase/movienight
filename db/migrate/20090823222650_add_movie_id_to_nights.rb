class AddMovieIdToNights < ActiveRecord::Migration
  def self.up
    add_column :nights, :movie_id, :integer, :default => nil
  end

  def self.down
    remove_column :nights, :movie_id
  end
end

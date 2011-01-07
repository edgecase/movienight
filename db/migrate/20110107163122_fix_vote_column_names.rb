class FixVoteColumnNames < ActiveRecord::Migration
  def self.up
    rename_column :votes, :watcher_id, :voter_id
    rename_column :votes, :votable_movie_id, :voteable_movie_id
  end

  def self.down
    rename_column :votes, :voteable_movie_id, :votable_movie_id
    rename_column :votes, :voter_id, :watcher_id
  end
end

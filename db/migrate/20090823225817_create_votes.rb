class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.integer :invitee_id
      t.integer :votable_movie_id

      t.timestamps
    end
  end

  def self.down
    drop_table :votes
  end
end

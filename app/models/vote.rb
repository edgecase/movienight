class Vote < ActiveRecord::Base
  belongs_to :watcher, :class_name => 'User'
  belongs_to :votable_movie
end

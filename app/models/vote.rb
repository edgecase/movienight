class Vote < ActiveRecord::Base
  belongs_to :invitee
  belongs_to :votable_movie
end

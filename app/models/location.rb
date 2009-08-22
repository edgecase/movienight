class Location < ActiveRecord::Base
  belongs_to :user
  has_many :nights

  validates_presence_of :street, :name
end

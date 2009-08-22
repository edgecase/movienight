require File.join(File.dirname(__FILE__), 'locations.rb')
require File.join(File.dirname(__FILE__), 'users.rb')
Factory.define :night do |n|
  user = Factory(:random_user)
  n.host user
  n.doors_open_time Time.now
  n.doors_open_date Date.today
  n.location Factory(:location, :user => user)
end

require File.join(File.dirname(__FILE__), 'users.rb')
Factory.define :night do |n|
  n.host Factory(:random_user)
  n.doors_open_time Time.now
  n.doors_open_date Date.today
end

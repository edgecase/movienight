require File.dirname(__FILE__) + '/nights'

Factory.define :invitee do |i|
  i.night Factory.create(:night)
  i.email "invitee@example.com"
end

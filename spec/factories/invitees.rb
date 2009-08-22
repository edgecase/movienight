Factory.define :invitee do |i|
  i.association :night
  i.email { "#{Time.now.to_f}@example.com" }
end

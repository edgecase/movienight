Factory.define(:invitation) do |inv|
  inv.association  :night
  inv.association  :invitee, :factory => :user
end

Factory.define(:night) do |n|
  n.curtain_date { 2.weeks.from_now }
  n.curtain_time { 2.weeks.from_now }
  n.association  :location
  n.host         {|i| i.location.user }
end

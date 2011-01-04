Factory.define(:friendship) do |f|
  f.user   { Factory(:user) }
  f.friend { Factory(:user) }
end


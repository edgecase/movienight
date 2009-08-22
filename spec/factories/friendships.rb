Factory.define :friendship do |f|
  f.association :user, :factory => :random_user
  f.association :friend, :factory => :random_user
end

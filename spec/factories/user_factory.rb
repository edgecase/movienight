Factory.define(:user) do |u|
  u.sequence(:email) {|n| "user#{n}@movienightapp.com" }
  u.sequence(:name)  {|n| "Some User-#{n}" }
  u.password 'password'
  u.password_confirmation 'password'
end

Factory.define(:invited_user, :parent => :user) do |u|
  u.invitee true
  u.password nil
  u.password_confirmation nil
end

Factory.define :user do |u|
  u.name "Bob User"
  u.login "bob"
  u.email "bob@example.com"
  u.password "123bobrules"
  u.password_confirmation "123bobrules"
end

Factory.define :random_user, :class => User do |u|
  u.name {Faker::Name.first_name}
  u.login {Faker::Internet.user_name}
  u.email {Faker::Internet.email}
  u.password "123bobrules"
  u.password_confirmation "123bobrules"
end

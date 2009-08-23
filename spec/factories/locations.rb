Factory.define :location do |l|
  l.street "2109 W 5th ave"
  l.city "Columbus"
  l.state "OH"
  l.name Faker::Company.name
end

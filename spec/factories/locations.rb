Factory.define :location do |l|
  l.street Faker::Address.street_address
  l.name Faker::Company.name
end

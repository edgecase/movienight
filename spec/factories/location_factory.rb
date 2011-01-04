Factory.define(:location) do |loc|
  loc.sequence(:street) {|n| "#{n} Any St." }
  loc.city  "Columbus"
  loc.state "OH"
  loc.name  "Apartment"
  loc.association :user
end


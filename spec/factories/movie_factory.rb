Factory.define(:movie) do |n|
  n.sequence(:title)   { |n| "Revenge of the Ners #{n}" }
  n.sequence(:tmdb_id) { |n| n.to_s }
  n.sequence(:imdb_id) { |n| "imdb#{n}" }
  n.release            { 2.weeks.ago }
end

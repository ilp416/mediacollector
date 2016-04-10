json.array!(@stuffs) do |stuff|
  json.extract! stuff, :id
  json.url stuff_url(stuff, format: :json)
end

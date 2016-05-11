json.array!(@admin_locations) do |admin_location|
  json.extract! admin_location, :id
  json.url admin_location_url(admin_location, format: :json)
end

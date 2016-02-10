json.extract! recommendation, :id, :name, :address, :latitude, :longitude, :link, :category
json.description do
  json.text recommendation.description
  json.html markdown(recommendation.description)
end
json.image do
  json.thumb asset_url(recommendation.image.url(:thumb))
  json.medium asset_url(recommendation.image.url(:medium))
  json.original asset_url(recommendation.image.url(:original))
end
json.google_maps_link recommendation.google_maps_link
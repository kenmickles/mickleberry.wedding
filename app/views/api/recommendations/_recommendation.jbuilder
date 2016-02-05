json.extract! recommendation, :id, :name, :address, :latitude, :longitude, :link, :category
json.description do
  json.text recommendation.description
  json.html markdown(recommendation.description)
end
json.image do
  json.medium asset_url(recommendation.image.url(:medium))
  json.original asset_url(recommendation.image.url(:original))
end
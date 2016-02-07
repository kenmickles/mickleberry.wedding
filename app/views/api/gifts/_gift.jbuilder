json.extract! gift, :id, :name, :description, :link, :purchased, :registry
json.image do
  json.original asset_url(gift.image.url)
  json.thumbnail asset_url(gift.image.url(:thumb))
end
json.price number_to_currency(gift.price)
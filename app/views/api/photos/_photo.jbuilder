json.extract! photo, :id, :caption, :created_at

json.image do
  json.medium asset_url(photo.image.url(:medium))
  json.original asset_url(photo.image.url(:original))
end

json.user do
  json.id photo.user_id
  json.name photo.photographer
  json.avatar asset_url(photo.avatar)
end

json.time_ago "#{time_ago_in_words(photo.created_at)} ago"
json.comment_count photo.comments.length
json.extract! user, :id, :name
json.avatar asset_url(user.avatar.url(:thumb))
json.extract! user, :id, :name, :attending
json.avatar asset_url(user.avatar.url(:thumb))
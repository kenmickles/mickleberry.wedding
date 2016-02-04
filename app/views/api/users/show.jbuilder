json.extract! @user, :id, :name, :token
json.avatar asset_url(@user.avatar.url(:thumb))
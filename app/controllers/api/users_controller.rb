class Api::UsersController < Api::ApiController
  before_action :require_token!

  def show
    @user = current_user
  end

  def create
    update
  end

  def update
    @user = current_user
    @user.name = params[:name].strip if params[:name]
    @user.avatar = params[:avatar] if params[:avatar]
    @user.save!
    render :show
  end
end
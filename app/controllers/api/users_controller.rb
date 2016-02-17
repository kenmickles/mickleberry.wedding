class Api::UsersController < Api::ApiController
  before_action :require_token!

  def show
    @user = current_user
  end

  def create
    save_and_show
  end

  def update
    save_and_show
  end

  protected

  def save_and_show
    @user = current_user
    @user.update!(user_params)
    render :show
  end

  def user_params
    params.require(:user).permit(:name, :avatar)
  end
end
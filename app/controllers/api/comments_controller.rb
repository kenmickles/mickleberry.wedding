class Api::CommentsController < Api::ApiController
  before_action :require_token!, only: [:create, :destroy]

  def index
    @comments = Photo.find(params[:photo_id]).comments.includes(:user).order(:id).page(params[:page]).per(50)
  end

  def create
    params.require(:message)

    @comment = Comment.create!(
      photo: Photo.find(params[:photo_id]),
      user: current_user,
      message: params[:message].strip
    )

    render :show
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
    render :show
  end
end
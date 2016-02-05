class Api::PhotosController < Api::ApiController
  before_action :require_token!, only: [:create, :destroy]

  def index
    @photos = Photo.order('id DESC').limit(10).includes(:user, :comments)

    if params[:before].present?
      @photos = @photos.where('id < ?', params[:before])
    end
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def create
    params.require(:image)

    @photo = Photo.create!(
      image: params[:image], 
      caption: params[:caption].try(:strip),
      user: current_user
    )

    render :show
  end

  def destroy
    @photo = current_user.photos.find(params[:id])
    @photo.destroy
    render :show
  end
end
class Api::PhotosController < Api::ApiController
  before_action :require_token!, only: [:create]

  def index
    @photos = Photo.order('id DESC').limit(10).includes(:user)

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
end
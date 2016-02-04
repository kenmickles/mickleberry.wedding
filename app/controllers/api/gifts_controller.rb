class Api::GiftsController < Api::ApiController
  def index
    @gifts = Gift.order(:name).page(params[:page]).per(10)
  end
end
class PhotosController < ApplicationController
  def index
    @page_title = "Photos"
    @photos = Photo.visible.order('created_at DESC').page(params[:page]).per(20)
  end
end
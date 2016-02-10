class PhotosController < ApplicationController
  def index
    @page_title = "Photos"
    @photos = Photo.all.order('created_at DESC').page(params[:page]).per(20)
  end
end
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :force_domain, if: -> { Rails.env.production? }

  protected

  def force_domain
    if request.host_with_port != 'mickleberry.wedding'
      redirect_to "http://mickleberry.wedding#{request.fullpath}", status: 301
    end
  end
end

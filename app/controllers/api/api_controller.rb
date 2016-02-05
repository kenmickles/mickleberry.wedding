class Api::ApiController < ActionController::Base
  before_action :set_view_path
  protect_from_forgery with: :null_session
  rescue_from Exception, with: :json_error

  protected

  def set_view_path
    prepend_view_path "#{Rails.root}/app/views/api"
  end

  def json_error(error)
    status = error.is_a?(ActiveRecord::RecordNotFound) ? 404 : 500
    render json: { error: error.message }, status: status
  end

  def current_user
    if params[:token].present?
      @current_user ||= User.find_or_create_by(token: params[:token])
    end
  end

  def require_token!
    params.require(:token)
  end
end
class Api::ApiController < ActionController::Base
  protect_from_forgery with: :null_session
  rescue_from Exception, with: :json_error

  protected

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
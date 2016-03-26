class Admin::AdminController < ApplicationController
  before_action :authenticate!

  protected

  def authenticate!
    authenticate_or_request_with_http_basic do |name, password|
      name == ENV['HTTP_USERNAME'] && password == ENV['HTTP_PASSWORD']
    end
  end
end
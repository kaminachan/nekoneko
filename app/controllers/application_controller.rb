class ApplicationController < ActionController::Base
  #before_action :set_current_user

  #フラッシュメッセージ
  add_flash_types :success, :info, :warning, :danger
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper

  #前のURLを覚えておく
  def set_request_from
    if session[:request_from]
      @request_from = session[:request_from]
    end
    session[:request_from] = request.original_url
  end
end
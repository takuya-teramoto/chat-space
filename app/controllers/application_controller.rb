class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :move_to_sign_in, if: :devise_controller?, except: [:new, :create]
  before_action :move_to_sign_in, unless: :devise_controller?
  before_action :move_to_root_path, if: :devise_controller?, only: [:new, :create]

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def move_to_sign_in
    redirect_to user_session_path unless user_signed_in?
  end

  def move_to_root_path
    redirect_to root_path if user_signed_in?
  end
end

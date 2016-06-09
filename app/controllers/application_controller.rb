class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include CartHelper
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
      redirect_to root_url, alert: exception.message
    else
      redirect_to new_user_session_path, alert: "Please sign in to access that page."
    end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password) }
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :name, :password, :password_confirmation) }

  end
end

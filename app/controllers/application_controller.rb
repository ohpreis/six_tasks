class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern
  include Pagy::Backend
  before_action :update_allowed_parameters, if: :devise_controller?
  helper_method :user_signed_in?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :time_zone, :password, :password_confirmation) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :email, :time_zone, :password, :current_password) }
  end

  def user_signed_in?
    current_user.present?
  end
end

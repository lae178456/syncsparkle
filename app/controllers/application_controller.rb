class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :configure_permitted_parameters, if: :devise_controller?

  def current_user_id
    current_user.id if user_signed_in?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:company, :email, :password, :password_confirmation, :subscription_type, :first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:company, :email, :password, :password_confirmation, :current_password, :subscription_type, :first_name, :last_name])
  end
end

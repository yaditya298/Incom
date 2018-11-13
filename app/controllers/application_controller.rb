# Application Controller
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Specify the page after successful sign in
  def after_sign_in_path_for(resource)
    user_contacts_path(resource)
  end

  # Adds the sanitized params for the user model
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name aadhar_number avatar])
  end
end

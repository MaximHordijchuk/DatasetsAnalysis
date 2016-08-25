class ApplicationController < ActionController::Base
  # Authenticate user before any action
  before_action :authenticate_user!

  # Permit :username and don't permit :email parameters
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Allow devise respond to JSON format
  config.to_prepare do
    DeviseController.respond_to :json
  end

  after_filter :set_csrf_cookie_for_ng

  # Create csrf token to AngularJS requests
  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  protected

  # Verify csrf token in request
  def verified_request?
    super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
  end

  # Add :username and remove :email from permitted parameters
  def configure_permitted_parameters
    added_attrs = [:username, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    flash[:warning] = "Access denied!"
    redirect_to root_url
  end

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || root_path
  end

  protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:role, :email, :password) }
        devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:role, :email, :password, :current_password) }
    end
end

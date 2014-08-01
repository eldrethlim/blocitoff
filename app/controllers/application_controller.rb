class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  after_filter :flash_headers

  before_action :configure_permitted_parameters, if: :devise_controller?

  def flash_headers
    
    return unless request.xhr?

    response.headers['x-flash'] = flash[:error] unless flash[:error].blank?
    response.headers['x-flash'] = flash[:notice] unless flash[:notice].blank?
    repsonse.headers['x-flash'] = flash[:warning] unless flash[:warning].blank?

    flash.discard
  end
 
  protected
 
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :email << :username
  end
end

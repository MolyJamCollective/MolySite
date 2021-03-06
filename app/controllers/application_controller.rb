class ApplicationController < ActionController::Base
  protect_from_forgery
  check_authorization :unless => :devise_controller?
  after_filter :store_location

  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
    redirect_to '/login', :alert => exception.message
  end

  def store_location
    session[:previous_url] = request.fullpath unless request.fullpath =~ /\/login/ || request.fullpath =~ /\/logout/ || request.fullpath =~ /\/dashboard/ || request.fullpath =~ /\/users/ || request.fullpath =~ /\/user/
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || '/news'
  end

  def after_update_path_for(resource)
    session[:previous_url] || '/news'
  end

  def after_sign_out_path_for(resource)
    session[:previous_url] || '/news'
  end
end

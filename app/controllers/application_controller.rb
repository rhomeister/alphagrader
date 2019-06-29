# frozen_string_literal: true

class ApplicationController < ActionController::Base
  check_authorization unless: :devise_controller?

  protect_from_forgery with: :exception
  before_action :redirect_to_primary_domain
  helper_method :page_title

  def redirect_to_primary_domain
    return if Rails.application.config.consider_all_requests_local || request.local?
    return if request.host == ENV.fetch('DOMAIN_NAME').split(':').first

    redirect_to "#{request.protocol}#{ENV.fetch('DOMAIN_NAME')}#{request.fullpath}", status: :moved_permanently
  end

  def page_title; end

  def access_denied(exception)
    redirect_to root_path, alert: exception.message
  end

  def authenticate_admin_user!
    redirect_to root_path unless current_user.try(:admin?)
  end

  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to root_path, flash: { error: 'You do not have access to the requested page' }
  end
end

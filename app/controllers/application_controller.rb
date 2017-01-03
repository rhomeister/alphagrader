class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :page_title
  def page_title
  end

  def access_denied(exception)
    redirect_to root_path, alert: exception.message
  end

  def authenticate_admin_user!
    redirect_to root_path unless current_user.try(:admin?)
  end
end

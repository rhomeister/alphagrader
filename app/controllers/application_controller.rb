class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :page_title
  def page_title
  end
end

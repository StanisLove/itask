module Authorized
  extend ActiveSupport::Concern

  included do
    helper_method :current_user
    helper_method :current_role
    before_action :require_auth
  end

  protected

  def require_auth
    return if current_user.present?
    redirect_to login_path, alert: t('http_error.unauthorized')
    false
  end

  def redirect_authorized
    redirect_to(root_path) if logged_in?
  end

  def logged_in?
    current_user.present?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def current_role
    @current_role ||= Role.new(session[:role_id])
  end
end

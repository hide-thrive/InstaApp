class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :require_login

  protected

  def not_authenticated
    redirect_to login_url
  end
end

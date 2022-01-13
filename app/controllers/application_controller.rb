class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :require_login
  before_action :set_search_posts_form

  private

  def not_authenticated
    redirect_to login_url
  end

  def set_search_posts_form
    @search_form = SearchForm.new(search_posts_params)
  end

  def search_posts_params
    params.fetch(:q, {}).permit(:content)
  end
end

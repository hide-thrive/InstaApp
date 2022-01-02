class SessionsController < ApplicationController
  skip_before_action :require_login

  def new
  end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_back_or_to new_user_path, flash: {success: 'ログインに成功しました！'}
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      render :new
    end
  end

  def destroy
    logout
    redirect_to login_url, flash: {warning: 'ログアウトしました。' }
  end
end

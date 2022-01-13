class UsersController < ApplicationController
  skip_before_action :require_login, only: %i(new create)
  before_action :set_user, only: %i(show edit update destroy)

  def index
    @users = User.all.page(params[:page]).order(created_at: :desc)
  end

  def show
    
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to login_url, flash: {success: "ユーザー「#{@user.name}」を登録しました。"}
    else
      flash.now[:danger] = "ユーザー登録に失敗しました。"
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, flash: {success: "ユーザー情報を更新しました。"}
    else
      flash.now[:danger] = "ユーザー情報の更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_url, flash: {warning: "ユーザー「#{@user.name}」を削除しました。"}
  end

  private

  def user_params
    params.require(:user).permit( :email, :password, :password_confirmation, :name, :avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end
end

class Mypage::AccountsController < ApplicationController
  before_action :set_user

  def edit
  end

  def update
    if @user.update(account_params)
      redirect_to edit_mypage_account_path, flash: {success: 'プロフィールを更新しました。'}
    else
      flash.now[:danger] = 'プロフィールの更新に失敗しました。'
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def account_params
    params.require(:user).permit(:email, :name, :avatar)
  end
end
class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :edit, :update, :destroy, :profile_show, :profile_edit, :profile_update]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :profile_show, :profile_edit, :profile_update]
  before_action :correct_user, only: [:show, :edit, :update, :destroy, :profile_edit, :profile_update]
  
  
  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      log_in(@user)
      flash[:success] = 'ユーザーを登録しました。'
      redirect_to root_url
    else
      flash[:danger] = 'ユーザー登録に失敗しました。'
      render :new
    end
  end

  def edit
  end

  def update
    
    if @user.update(user_params)
      flash[:success] = '本人情報が変更されました。'
      redirect_to @user
    else
      flash.now[:danger] = '本人情報は変更されませんでした。'
      render :edit
    end
  end

  def destroy
    @user.destroy
    
    flash[:success] = '退会しました。'
    redirect_to root_url
  end
  
  def profile_show
  end
  
  def profile_edit
  end
  
  def profile_update

    if @user.update(user_params)
      flash[:success] = 'プロフィールを変更しました。'
      redirect_to profile_show_user_url(@user)
    else
      flash.now[:danger] = 'プロフィールは変更されませんでした。'
      render :profile_edit
    end
  end
  
  private
  
  def correct_user
    @user = User.find(params[:id])
    unless current_user.id == @user.id
      redirect_to root_url
    end
  end
  
  def set_user
    if User.exists?(id: params[:id])
      @user = User.find(params[:id])
    else
      redirect_to root_url
    end
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :self_introduction)
  end
end

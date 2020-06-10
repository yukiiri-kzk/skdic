class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]
  
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザーを登録しました。'
      redirect_to root_url
    else
      flash[:danger] = 'ユーザー登録に失敗しました。'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:success] = '本人情報が変更されました。'
      redirect_to @user
    else
      flash.now[:danger] = '本人情報は変更されませんでした。'
      render :edit
    end
  end

  def destroy
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

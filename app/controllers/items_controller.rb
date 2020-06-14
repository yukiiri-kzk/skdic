class ItemsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  
  def index
    @items = current_user.items.order(id: :desc).page(params[:page]).per(10)
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = current_user.items.build
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      flash[:success] = 'アイテムを登録しました。'
      redirect_to @item
    else
      flash.now[:danger] = 'アイテムの投稿に登録しました。'
      render :new
    end
  end

  def edit
    @item = current_user.items.find_by(id: params[:id])
  end

  def update
    @item = current_user.items.find_by(id: params[:id])
    if @item.update(item_params)
      flash[:success] = 'アイテム情報が変更されました。'
      redirect_to @item
    else
      flash.now[:danger] = 'アイテム情報は変更されませんでした。'
      render :edit
    end
  end
  
  private
  
  def correct_user
    @item = current_user.items.find_by(id: params[:id])
    unless @item
      redirect_to root_url
    end
  end
  
  def item_params
    params.require(:item).permit(:name, :explanation, :image)
  end
  
end

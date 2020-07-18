class ItemsController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_item, only: [:show]
  before_action :correct_item, only: [:edit, :update, :completed, :incomplete, :destroy]
  
  
  def index
    @items = current_user.items.order(id: :desc).page(params[:page]).per(10)
  end

  def show
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
      flash.now[:danger] = 'アイテムの投稿に失敗しました。'
      render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      flash[:success] = 'アイテム情報が変更されました。'
      redirect_to @item
    else
      flash.now[:danger] = 'アイテム情報は変更されませんでした。'
      render :edit
    end
  end
  
  def destroy
    @item.destroy
    flash[:success] = 'アイテムを削除しました。'
    redirect_to items_url
  end
  
  def completed
    @item = Item.find(params[:id])
    @item.update(done: '取引済み')
    flash[:success] = 'アイテムを取引済みにしました。'
    redirect_to @item
  end
  
  def incomplete
    @item = Item.find(params[:id])
    @item.update(done: nil)
    flash[:success] = 'アイテムの取引済みを解除しました。'
    redirect_to @item
  end
  
  private
  
  def correct_item
    @item = current_user.items.find_by(id: params[:id])
    unless @item
      redirect_to root_url
    end
  end
  
  def set_item
    if Item.exists?(id: params[:id])
      @item = Item.find(params[:id])
    else
      redirect_to root_url
    end
  end
  
  def item_params
    params.require(:item).permit(:name, :explanation, :image, :category_id, :area_id)
  end
  
end

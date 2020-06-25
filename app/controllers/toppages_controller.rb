class ToppagesController < ApplicationController
  
  def index
    @items = Item.all.order(id: :desc).page(params[:page]).per(10)
    @current_user = current_user&.id
  end
end

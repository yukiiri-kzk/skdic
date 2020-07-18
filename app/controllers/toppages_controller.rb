class ToppagesController < ApplicationController
  
  def index
    @items = Item.all.order(id: :desc).page(params[:page]).per(12)
    @current_user = current_user&.id
    
    if params[:name].present?
      @items = @items.get_by_name(params[:name])
    end
    if params[:category_id].present?
      @items = @items.get_by_category(params[:category_id])
    end
    if params[:area_id].present?
      @items = @items.get_by_area(params[:area_id])
    end
  end
end

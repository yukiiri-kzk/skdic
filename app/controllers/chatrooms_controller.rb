class ChatroomsController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_chatroom, only: [:show, :destroy]
  before_action :our_chatroom, only: [:show]
  before_action :correct_chatroom, only: [:destroy]
  
  def index
    @chatrooms = Chatroom.all.where(exhibitor_id: current_user.id).order(id: :desc).page(params[:page]).per(10)
  end
  
  def show
    @message = current_user.messages.build
    @messages = @chatroom.messages.order(id: :desc)
  end

  def create
    @chatroom = Chatroom.new(chatroom_params)
      if Chatroom.where(chatroom_params).exists? || current_user == @chatroom.item.user
        redirect_to other_chatrooms_url
      else
        @chatroom.save
        flash[:success] = 'ルームを作成しました。'
        redirect_to other_chatrooms_url
      end
  end
  
  def destroy
    @chatroom.destroy
    flash[:success] = 'ルームを削除しました。'
    if @chatroom.exhibitor_id == current_user.id
      redirect_to chatrooms_url
    elsif @chatroom.wanter_id == current_user.id
      redirect_to other_chatrooms_url
    end
  end
  
  private
  
  def our_chatroom
    unless current_user.id == @chatroom.exhibitor_id || current_user.id == @chatroom.wanter_id
      redirect_to root_url
    end
  end
  
  def correct_chatroom
    @chatroom = current_user.chatrooms.find_by(id: params[:id])
    unless @chatroom
      redirect_to root_url
    end
  end
  
  def set_chatroom
    if Chatroom.exists?(id: params[:id])
      @chatroom = Chatroom.find(params[:id])
    else
      redirect_to root_url
    end
  end
  
  def chatroom_params
    params.require(:chatroom).permit(:exhibitor_id, :wanter_id, :item_id)
  end
end

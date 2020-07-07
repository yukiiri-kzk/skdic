class ChatroomsController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_chatroom, only: [:show]
  before_action :correct_chatroom, only: [:show]
  
  def index
    @chatrooms = Chatroom.all.where(exhibitor_id: current_user.id).order(id: :desc).page(params[:page]).per(10)
  end
  
  def show
    @message = current_user.messages.build
    @messages = @chatroom.messages.order(id: :desc)
  end

  def create
    @chatroom = Chatroom.new(chatroom_params)
      if Chatroom.where(chatroom_params).exists?
        redirect_to other_chatrooms_url
      else
        @chatroom.save
        flash[:success] = 'チャットルームを作成しました。'
        redirect_to other_chatrooms_url
      end
  end
  
  private
  
  def correct_chatroom
    unless current_user.id == @chatroom.exhibitor_id || current_user.id == @chatroom.wanter_id
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

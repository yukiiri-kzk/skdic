class MessagesController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_message, only: [:destroy]

  def create
    @message = current_user.messages.build(message_params)
    if @message.save
      redirect_to chatroom_url(@message.chatroom.id)
    else
      redirect_to chatroom_url(@message.chatroom.id)
    end
  end
  
  def destroy
    @message.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def message_params
    params.require(:message).permit(:content, :user_id, :chatroom_id)
  end
  
  def correct_message
    @message = current_user.messages.find_by(id: params[:id])
    unless @message
      redirect_to root_url
    end
  end
end

class MessagesController < ApplicationController
  before_action :require_user_logged_in

  def create
    @message = current_user.messages.build(message_params)
    if @message.save
      redirect_to chatroom_url(@message.chatroom.id)
    else
      redirect_to chatroom_url(@message.chatroom.id)
    end
  end
  
  private
  
  def message_params
    params.require(:message).permit(:content, :user_id, :chatroom_id)
  end
end

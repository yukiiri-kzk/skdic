class OtherChatroomsController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    @chatrooms = Chatroom.all.where(wanter_id: current_user.id).order(id: :desc).page(params[:page]).per(10)
  end
end

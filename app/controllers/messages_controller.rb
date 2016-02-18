class MessagesController < ApplicationController
  before_action :find_message, only: [:show, :destroy]
  before_action :require_user, only: [:create]
  before_action :require_user_or_admin, only: [:destroy] 

  def index 
    if logged_in_as_admin?
      @messages = Message.page(params[:page]).per(8)
    else
      @messages = Message.where("seeable = ? or user_id = ?", true, current_user.id).page(params[:page]).per(8)
    end
    @message = Message.new      
  end

  def show
  end


  def create
    @message = Message.create(message_params)
    @message.user = current_user
    if @message.save
      flash[:notice] = "您的留言已新增"
      redirect_to messages_path
    else 
      flash[:alert] = "發生錯誤, 請重新留言(標題/內容不可留白)"
      redirect_to messages_path
    end
  end

  def destroy
    @message.destroy
    flash[:notice] = "您已刪除此留言"
    redirect_to messages_path
  end

  private

  def message_params
    params.require(:message).permit(:anonymous, :title, :body)
  end

  def find_message
    @message = Message.find(params[:id])
  end
end

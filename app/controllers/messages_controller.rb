class MessagesController < ApplicationController
  before_action :find_message, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]

  def index 
    @messages = Message.all.order("created_at DESC")    
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
      @messages = Message.all.order("created_at DESC")    
      render 'message_sidebar'
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

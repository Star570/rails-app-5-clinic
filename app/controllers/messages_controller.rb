class MessagesController < ApplicationController
  before_action :find_message, only: [:show, :edit, :update, :destroy]

  def index 
    @messages = Message.all.order("created_at DESC")    
    @message = Message.new      
  end

  def show
  end


  def create
    @message = Message.create(message_params)
    if @message.save
      redirect_to messages_path
    else 
      @messages = Message.all.order("created_at DESC")    
      render 'message_sidebar'
    end
  end

  def destroy
    @message.destroy
    redirect_to messages_path
  end

  private

  def message_params
    params.require(:message).permit(:name, :title, :body)
  end

  def find_message
    @message = Message.find(params[:id])
  end
end

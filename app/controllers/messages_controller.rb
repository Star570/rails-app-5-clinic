class MessagesController < ApplicationController
  before_action :find_message, only: [:show, :edit, :update, :destroy]

  def show
  end


  def create
    @message = Message.create(message_params)
    if @message.save
      redirect_to message_board_path
    else 
      render :new
    end
  end

  def destroy
    @message.destroy
    redirect_to message_board_path
  end

  private

  def message_params
    params.require(:message).permit(:name, :title, :body)
  end

  def find_message
    @message = Message.find(params[:id])
  end
end

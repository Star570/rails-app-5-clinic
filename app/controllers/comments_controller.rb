class CommentsController < ApplicationController
  before_action :require_admin

  def create
    @message = Message.find(params[:message_id])
    @comment = @message.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:notice] = "您的回覆已新增"
      redirect_to message_path(@message)
    else
      redirect_back_or_to root_path
    end
  end

  def destroy
    @message = Message.find(params[:message_id])
    @comment = @message.comments.find(params[:id])
    @comment.destroy
    flash[:notice] = "您已刪除此回覆"
    redirect_to message_path(@message)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
